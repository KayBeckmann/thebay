import 'dart:async';

import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openpgp/openpgp.dart';

import '../l10n/app_localizations.dart';
import '../services/pgp_key_service.dart';
import '../utils/date_formatter.dart';

/// Screen für PGP Key Management.
/// Ermöglicht Key-Generierung, Export, Import und Server-Synchronisation.
class PgpKeyScreen extends StatefulWidget {
  final PgpKeyService pgpKeyService;

  const PgpKeyScreen({
    super.key,
    required this.pgpKeyService,
  });

  @override
  State<PgpKeyScreen> createState() => _PgpKeyScreenState();
}

class _PgpKeyScreenState extends State<PgpKeyScreen> {
  PgpKeyStatus? _keyStatus;
  bool _isLoading = true;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _loadKeyStatus();
  }

  Future<void> _loadKeyStatus() async {
    setState(() => _isLoading = true);
    try {
      final status = await widget.pgpKeyService.getKeyStatus();
      setState(() {
        _keyStatus = status;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorLoading(e.toString()))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pgpKeys),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadKeyStatus,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildStatusCard(),
                  const SizedBox(height: 16),
                  if (_keyStatus?.hasLocalPrivateKey == true) ...[
                    _buildKeyInfoCard(),
                    const SizedBox(height: 16),
                    _buildExportCard(),
                    const SizedBox(height: 16),
                    _buildServerBackupCard(),
                    const SizedBox(height: 16),
                  ],
                  _buildGenerateCard(),
                  const SizedBox(height: 16),
                  _buildImportCard(),
                  const SizedBox(height: 16),
                  _buildSecurityInfoCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildStatusCard() {
    final l10n = AppLocalizations.of(context)!;
    final isConfigured = _keyStatus?.isFullyConfigured ?? false;
    final hasLocal = _keyStatus?.hasLocalPrivateKey ?? false;
    final hasServer = _keyStatus?.hasServerPublicKey ?? false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isConfigured ? Icons.check_circle : Icons.warning,
                  color: isConfigured ? Colors.green : Colors.orange,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isConfigured
                            ? l10n.keyConfigured
                            : l10n.keyIncomplete,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        isConfigured
                            ? l10n.canSendEncryptedMessages
                            : _getStatusMessage(hasLocal, hasServer),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!isConfigured && hasLocal && !hasServer) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _uploadPublicKey,
                  icon: const Icon(Icons.cloud_upload),
                  label: Text(l10n.uploadPublicKey),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getStatusMessage(bool hasLocal, bool hasServer) {
    final l10n = AppLocalizations.of(context)!;
    if (!hasLocal && !hasServer) {
      return l10n.generateOrImportKey;
    } else if (hasLocal && !hasServer) {
      return l10n.privateKeyLocalPublicKeyMissing;
    } else if (!hasLocal && hasServer) {
      return l10n.publicKeyOnServerPrivateKeyMissing;
    }
    return l10n.keysMismatch;
  }

  Widget _buildKeyInfoCard() {
    final l10n = AppLocalizations.of(context)!;
    final fingerprint = _keyStatus?.localFingerprint ?? '';
    final serverKey = _keyStatus?.serverKey;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.keyInformation,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(l10n.fingerprint, _formatFingerprint(fingerprint)),
            if (serverKey != null) ...[
              _buildInfoRow(l10n.algorithm, serverKey.algorithm),
              _buildInfoRow(l10n.keySize, '${serverKey.keySize} Bit'),
              _buildInfoRow(l10n.identity, serverKey.keyIdentity),
              _buildInfoRow(
                l10n.createdAt,
                DateFormatter.formatDate(context, serverKey.createdAt),
              ),
            ],
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _copyToClipboard(fingerprint, l10n.fingerprint),
              icon: const Icon(Icons.copy, size: 18),
              label: Text(l10n.copyFingerprint),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateCard() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.add_circle_outline),
                const SizedBox(width: 8),
                Text(
                  l10n.generateNewKey,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.createsNewEd25519Key,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (_keyStatus?.hasLocalPrivateKey == true) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.existingKeyWillBeReplaced,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isGenerating ? null : () => _showGenerateDialog(),
                icon: _isGenerating
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.vpn_key),
                label: Text(_isGenerating ? l10n.generating : l10n.generateKey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportCard() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.download),
                const SizedBox(width: 8),
                Text(
                  l10n.exportKey,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.exportPrivateKeyForBackup,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showExportDialog,
                icon: const Icon(Icons.key),
                label: Text(l10n.exportPrivateKey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportCard() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.upload),
                const SizedBox(width: 8),
                Text(
                  l10n.importKey,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.importExistingPrivateKey,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showImportDialog,
                icon: const Icon(Icons.file_upload),
                label: Text(l10n.pastePrivateKey),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showDownloadBackupDialog,
                icon: const Icon(Icons.cloud_download),
                label: Text(l10n.loadFromServerBackup),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityInfoCard() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.security,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.securityNotices,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSecurityItem(
              '• ${l10n.privateKeyNeverLeavesDevice}',
            ),
            _buildSecurityItem(
              '• ${l10n.onlyPublicKeyStoredOnServer}',
            ),
            _buildSecurityItem(
              '• ${l10n.regularBackupsRecommended}',
            ),
            _buildSecurityItem(
              '• ${l10n.lostKeyCannotDecryptOldMessages}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _buildServerBackupCard() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.cloud_upload),
                const SizedBox(width: 8),
                Text(
                  l10n.serverBackup,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.storePrivateKeyEncryptedOnServer,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showBackupWarningDialog,
                icon: const Icon(Icons.backup),
                label: Text(l10n.createEncryptedBackup),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBackupWarningDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.warning_amber_rounded,
          size: 48,
          color: Theme.of(context).colorScheme.error,
        ),
        title: Text(l10n.securityWarning),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.aboutToStorePrivateKeyOnServer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.keyWillBeEncryptedBeforeUpload,
            ),
            const SizedBox(height: 12),
            _buildWarningItem(
              l10n.chooseStrongUniquePassword,
            ),
            _buildWarningItem(
              l10n.passwordCannotBeReset,
            ),
            _buildWarningItem(
              l10n.backupWorthlessWithoutPassword,
            ),
            _buildWarningItem(
              l10n.serverOperatorMightGuessPassword,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _showBackupPasswordDialog();
            },
            child: Text(l10n.understandProceed),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_right,
            size: 20,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  void _showBackupPasswordDialog() {
    final l10n = AppLocalizations.of(context)!;
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();
    bool obscurePassword = true;
    bool obscureConfirm = true;
    String? error;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.setBackupPassword),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.chooseStrongPasswordForBackup,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: l10n.password,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setDialogState(() => obscurePassword = !obscurePassword);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmController,
                  obscureText: obscureConfirm,
                  decoration: InputDecoration(
                    labelText: l10n.confirmPassword,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setDialogState(() => obscureConfirm = !obscureConfirm);
                      },
                    ),
                  ),
                ),
                if (error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                final password = passwordController.text;
                final confirm = confirmController.text;

                if (password.length < 8) {
                  setDialogState(() {
                    error = l10n.passwordMinLength;
                  });
                  return;
                }

                if (password != confirm) {
                  setDialogState(() {
                    error = l10n.passwordsDontMatch;
                  });
                  return;
                }

                Navigator.pop(context);
                _uploadEncryptedBackup(password);
              },
              child: Text(l10n.createBackup),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadEncryptedBackup(String password) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    try {
      final privateKey = await widget.pgpKeyService.getPrivateKey();
      if (privateKey == null) {
        throw Exception(l10n.noPrivateKey);
      }

      final fingerprint = await widget.pgpKeyService.getFingerprint();
      if (fingerprint == null) {
        throw Exception(l10n.noFingerprint);
      }

      // Verschlüssele den Private Key symmetrisch mit dem Passwort
      print('[PgpKeyScreen] Verschlüssele Private Key für Backup...');
      final encryptedKey = await OpenPGP.encryptSymmetric(
        privateKey,
        password,
      );

      // Generiere Salt für KDF-Dokumentation
      final salt = DateTime.now().millisecondsSinceEpoch.toRadixString(16);

      // Lade zum Server hoch
      print('[PgpKeyScreen] Lade verschlüsseltes Backup hoch...');
      await widget.pgpKeyService.uploadEncryptedBackup(
        encryptedPrivateKey: encryptedKey,
        fingerprint: fingerprint,
        salt: salt,
        kdfParams: 'AES-256-PGP-SYMMETRIC',
      );

      print('[PgpKeyScreen] Backup erfolgreich hochgeladen');

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.backupSuccessfullySaved),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('[PgpKeyScreen] Fehler beim Backup: $e');
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorBackup(e.toString()))),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showDownloadBackupDialog() async {
    // Zeige Ladeindikator während wir prüfen, ob Backups existieren
    setState(() => _isLoading = true);

    try {
      // Prüfe, ob Backups vorhanden sind
      print('[PgpKeyScreen] Lade Liste der Backups...');
      final backups = await widget.pgpKeyService.listBackups();

      setState(() => _isLoading = false);

      if (!mounted) return;

      if (backups.isEmpty) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.noBackupOnServer),
          ),
        );
        return;
      }

      // Zeige Dialog zur Auswahl des Backups (falls mehrere)
      _showSelectBackupDialog(backups);
    } catch (e) {
      setState(() => _isLoading = false);
      print('[PgpKeyScreen] Fehler beim Laden der Backups: $e');
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorLoading(e.toString()))),
        );
      }
    }
  }

  void _showSelectBackupDialog(List<EncryptedKeyBackup> backups) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectBackup),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.selectBackupToRestore,
              ),
              const SizedBox(height: 16),
              ...backups.map((backup) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.vpn_key),
                      title: Text(
                        'Fingerprint: ${_formatFingerprintShort(backup.fingerprint)}',
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                      ),
                      subtitle: Text(
                        'Erstellt: ${DateFormatter.formatDate(context, backup.createdAt)}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pop(context);
                        _showRestorePasswordDialog(backup);
                      },
                    ),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  void _showRestorePasswordDialog(EncryptedKeyBackup backup) {
    final l10n = AppLocalizations.of(context)!;
    final passwordController = TextEditingController();
    bool obscurePassword = true;
    String? error;
    bool isRestoring = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.decryptBackup),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fingerprint: ${_formatFingerprintShort(backup.fingerprint)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.enterPasswordForBackup,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  enabled: !isRestoring,
                  decoration: InputDecoration(
                    labelText: l10n.backupPassword,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setDialogState(() => obscurePassword = !obscurePassword);
                      },
                    ),
                  ),
                ),
                if (error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ],
                if (isRestoring) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 12),
                      Text(l10n.decryptingAndImporting),
                    ],
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isRestoring ? null : () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: isRestoring
                  ? null
                  : () async {
                      final password = passwordController.text;

                      if (password.isEmpty) {
                        setDialogState(() {
                          error = l10n.pleaseEnterPassword;
                        });
                        return;
                      }

                      setDialogState(() {
                        isRestoring = true;
                        error = null;
                      });

                      try {
                        await _restoreFromBackup(backup, password);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        setDialogState(() {
                          isRestoring = false;
                          error = l10n.decryptionFailedWrongPassword;
                        });
                      }
                    },
              child: Text(l10n.restore),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _restoreFromBackup(
    EncryptedKeyBackup backup,
    String password,
  ) async {
    print('[PgpKeyScreen] Starte Wiederherstellung aus Backup...');

    // Entschlüssele den Private Key
    print('[PgpKeyScreen] Entschlüssele Private Key...');
    final decryptedKey = await OpenPGP.decryptSymmetric(
      backup.encryptedPrivateKey,
      password,
    );

    // Validiere, dass es ein gültiger PGP Key ist
    if (!decryptedKey.contains('-----BEGIN PGP PRIVATE KEY BLOCK-----')) {
      final l10n = AppLocalizations.of(context)!;
      throw Exception(l10n.invalidKeyAfterDecryption);
    }

    print('[PgpKeyScreen] Entschlüsselung erfolgreich, importiere Key...');

    // Importiere den Key
    final success = await widget.pgpKeyService.importPrivateKey(decryptedKey);
    if (!success) {
      throw Exception('Import fehlgeschlagen');
    }

    print('[PgpKeyScreen] Key erfolgreich importiert');

    // Aktualisiere Status
    await _loadKeyStatus();

    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.keySuccessfullyRestored),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  String _formatFingerprintShort(String fingerprint) {
    final clean = fingerprint.replaceAll(' ', '').toUpperCase();
    if (clean.length > 16) {
      return '${clean.substring(0, 8)}...${clean.substring(clean.length - 8)}';
    }
    return clean;
  }

  void _showGenerateDialog() {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passphraseController = TextEditingController();
    bool usePassphrase = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.generateKey),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: l10n.name,
                    hintText: l10n.yourName,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: l10n.emailOptional,
                    hintText: l10n.yourEmailCom,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: usePassphrase,
                  onChanged: (value) {
                    setDialogState(() => usePassphrase = value ?? false);
                  },
                  title: Text(l10n.protectWithPassphrase),
                  subtitle: Text(l10n.recommendedForSecurity),
                  contentPadding: EdgeInsets.zero,
                ),
                if (usePassphrase) ...[
                  const SizedBox(height: 8),
                  TextField(
                    controller: passphraseController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: l10n.passphrase,
                      hintText: l10n.enterSecurePassphrase,
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () async {
                if (nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.pleaseEnterName)),
                  );
                  return;
                }

                Navigator.pop(context);
                await _generateKey(
                  name: nameController.text,
                  email: emailController.text.isEmpty
                      ? 'user@local'
                      : emailController.text,
                  passphrase: usePassphrase ? passphraseController.text : null,
                );
              },
              child: Text(l10n.generateKey),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateKey({
    required String name,
    required String email,
    String? passphrase,
  }) async {
    print('[PgpKeyScreen] _generateKey() gestartet');
    setState(() => _isGenerating = true);

    // Zeige Progress-Dialog
    _showGeneratingProgressDialog();

    try {
      // Generiere Schlüsselpaar
      print('[PgpKeyScreen] Rufe pgpKeyService.generateKeyPair() auf...');
      final keyPair = await widget.pgpKeyService.generateKeyPair(
        name: name,
        email: email,
        passphrase: passphrase,
      );
      print('[PgpKeyScreen] generateKeyPair() zurückgekehrt');

      // Speichere Private Key lokal
      print('[PgpKeyScreen] Speichere Private Key...');
      await widget.pgpKeyService.storePrivateKey(
        keyPair.privateKey,
        keyPair.fingerprint,
      );
      print('[PgpKeyScreen] Private Key gespeichert');

      // Lade Public Key zum Server hoch
      print('[PgpKeyScreen] Lade Public Key zum Server...');
      await widget.pgpKeyService.uploadPublicKey(
        keyPair.publicKey,
        keyPair.identity,
        keyPair.fingerprint,
        keyPair.algorithm,
        keyPair.keySize,
      );
      print('[PgpKeyScreen] Public Key hochgeladen');

      // Schließe Progress-Dialog
      if (mounted) Navigator.of(context).pop();

      // Status aktualisieren
      print('[PgpKeyScreen] Aktualisiere Status...');
      await _loadKeyStatus();

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.keySuccessfullyGenerated),
            backgroundColor: Colors.green,
          ),
        );
      }
      print('[PgpKeyScreen] _generateKey() erfolgreich abgeschlossen');
    } catch (e) {
      print('[PgpKeyScreen] FEHLER in _generateKey(): $e');
      // Schließe Progress-Dialog bei Fehler
      if (mounted) Navigator.of(context).pop();

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorGeneration(e.toString()))),
        );
      }
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  void _showGeneratingProgressDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.generatingKey,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.generatingEd25519Key,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
              const _GeneratingTimer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadPublicKey() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    try {
      final privateKey = await widget.pgpKeyService.getPrivateKey();
      if (privateKey == null) {
        throw Exception(l10n.noPrivateKey);
      }

      final fingerprint = await widget.pgpKeyService.getFingerprint();
      if (fingerprint == null) {
        throw Exception(l10n.noFingerprint);
      }

      // Extrahiere Public Key aus Private Key
      final publicKey = await OpenPGP.convertPrivateKeyToPublicKey(privateKey);
      final metadata = await OpenPGP.getPublicKeyMetadata(publicKey);

      // Lade Public Key zum Server hoch
      print('[PgpKeyScreen] Lade Public Key zum Server hoch...');
      await widget.pgpKeyService.uploadPublicKey(
        publicKey,
        metadata.identities.isNotEmpty
            ? '${metadata.identities.first.name} <${metadata.identities.first.email}>'
            : 'Unknown',
        fingerprint,
        metadata.algorithm,
        256, // ECC key size
      );
      print('[PgpKeyScreen] Public Key hochgeladen');

      await _loadKeyStatus();
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.publicKeySuccessfullyUploaded),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('[PgpKeyScreen] Fehler beim Hochladen: $e');
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorUploading(e.toString()))),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showExportDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final privateKey = await widget.pgpKeyService.exportPrivateKey();

    if (privateKey == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.noPrivateKey)),
        );
      }
      return;
    }

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.privateKeyExport),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.keepKeySafe,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    privateKey,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.close),
          ),
          FilledButton.icon(
            onPressed: () {
              _copyToClipboard(privateKey, 'Private Key');
              Navigator.pop(context);
            },
            icon: const Icon(Icons.copy),
            label: Text(l10n.copyFingerprint),
          ),
        ],
      ),
    );
  }

  void _showImportDialog() {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.importPrivateKey),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.pastePrivateKeyInPgpFormat,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: l10n.beginPgpPrivateKeyBlock,
                  border: const OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.pleasePasteKey)),
                );
                return;
              }

              final success = await widget.pgpKeyService
                  .importPrivateKey(controller.text);

              if (mounted) {
                final l10n = AppLocalizations.of(context)!;
                Navigator.pop(context);
                if (success) {
                  await _loadKeyStatus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.privateKeySuccessfullyImported),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.invalidKeyFormat),
                    ),
                  );
                }
              }
            },
            child: Text(l10n.send),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text, String label) {
    final l10n = AppLocalizations.of(context)!;
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.copiedToClipboard(label))),
    );
  }

  String _formatFingerprint(String fingerprint) {
    if (fingerprint.isEmpty) return '-';
    // Format: XXXX XXXX XXXX XXXX XXXX  XXXX XXXX XXXX XXXX XXXX
    final clean = fingerprint.replaceAll(' ', '').toUpperCase();
    final parts = <String>[];
    for (var i = 0; i < clean.length; i += 4) {
      final end = (i + 4 > clean.length) ? clean.length : i + 4;
      parts.add(clean.substring(i, end));
    }
    if (parts.length > 5) {
      return '${parts.sublist(0, 5).join(' ')}  ${parts.sublist(5).join(' ')}';
    }
    return parts.join(' ');
  }
}

/// Widget das die verstrichene Zeit während der Key-Generierung anzeigt.
class _GeneratingTimer extends StatefulWidget {
  const _GeneratingTimer();

  @override
  State<_GeneratingTimer> createState() => _GeneratingTimerState();
}

class _GeneratingTimerState extends State<_GeneratingTimer> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final minutes = _seconds ~/ 60;
    final secs = _seconds % 60;
    final formattedTime = '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    return Text(
      l10n.elapsedTime(formattedTime),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontFamily: 'monospace',
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
