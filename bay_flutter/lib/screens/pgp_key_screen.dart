import 'dart:async';

import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openpgp/openpgp.dart';

import '../services/pgp_key_service.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Laden: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PGP-Schlüssel'),
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
                            ? 'Schlüssel eingerichtet'
                            : 'Schlüssel nicht vollständig',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        isConfigured
                            ? 'Du kannst verschlüsselte Nachrichten senden und empfangen.'
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
                  label: const Text('Public Key hochladen'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getStatusMessage(bool hasLocal, bool hasServer) {
    if (!hasLocal && !hasServer) {
      return 'Generiere einen neuen Schlüssel oder importiere einen vorhandenen.';
    } else if (hasLocal && !hasServer) {
      return 'Private Key vorhanden, aber Public Key nicht auf dem Server.';
    } else if (!hasLocal && hasServer) {
      return 'Public Key auf Server, aber Private Key fehlt lokal.';
    }
    return 'Schlüssel stimmen nicht überein.';
  }

  Widget _buildKeyInfoCard() {
    final fingerprint = _keyStatus?.localFingerprint ?? '';
    final serverKey = _keyStatus?.serverKey;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schlüssel-Informationen',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Fingerprint', _formatFingerprint(fingerprint)),
            if (serverKey != null) ...[
              _buildInfoRow('Algorithmus', serverKey.algorithm),
              _buildInfoRow('Schlüsselgröße', '${serverKey.keySize} Bit'),
              _buildInfoRow('Identität', serverKey.keyIdentity),
              _buildInfoRow(
                'Erstellt',
                _formatDate(serverKey.createdAt),
              ),
            ],
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _copyToClipboard(fingerprint, 'Fingerprint'),
              icon: const Icon(Icons.copy, size: 18),
              label: const Text('Fingerprint kopieren'),
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
                  'Neuen Schlüssel generieren',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Erstellt einen neuen Ed25519/Curve25519 Schlüssel. '
              'Dies dauert nur wenige Sekunden.',
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
                        'Der vorhandene Schlüssel wird ersetzt!',
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
                label: Text(_isGenerating ? 'Generiere...' : 'Schlüssel generieren'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportCard() {
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
                  'Schlüssel exportieren',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Exportiere deinen Private Key für ein Backup. '
              'Bewahre ihn sicher auf!',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showExportDialog,
                icon: const Icon(Icons.key),
                label: const Text('Private Key exportieren'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportCard() {
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
                  'Schlüssel importieren',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Importiere einen vorhandenen Private Key '
              '(z.B. von einem Backup oder anderem Gerät).',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showImportDialog,
                icon: const Icon(Icons.file_upload),
                label: const Text('Private Key einfügen'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showDownloadBackupDialog,
                icon: const Icon(Icons.cloud_download),
                label: const Text('Vom Server-Backup laden'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityInfoCard() {
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
                  'Sicherheitshinweise',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSecurityItem(
              '• Dein Private Key verlässt niemals dieses Gerät',
            ),
            _buildSecurityItem(
              '• Nur der Public Key wird auf dem Server gespeichert',
            ),
            _buildSecurityItem(
              '• Erstelle regelmäßig Backups deines Private Keys',
            ),
            _buildSecurityItem(
              '• Bei Verlust des Keys können alte Nachrichten nicht entschlüsselt werden',
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
                  'Server-Backup',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Speichere deinen Private Key verschlüsselt auf dem Server. '
              'So kannst du ihn auf einem anderen Gerät wiederherstellen.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showBackupWarningDialog,
                icon: const Icon(Icons.backup),
                label: const Text('Verschlüsseltes Backup erstellen'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBackupWarningDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.warning_amber_rounded,
          size: 48,
          color: Theme.of(context).colorScheme.error,
        ),
        title: const Text('Sicherheitshinweis'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Du bist dabei, deinen Private Key auf dem Server zu speichern.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Der Key wird mit einem Passwort verschlüsselt, bevor er hochgeladen wird. '
              'Trotzdem solltest du folgendes beachten:',
            ),
            const SizedBox(height: 12),
            _buildWarningItem(
              'Wähle ein starkes, einzigartiges Passwort',
            ),
            _buildWarningItem(
              'Dieses Passwort kann NICHT zurückgesetzt werden',
            ),
            _buildWarningItem(
              'Ohne Passwort ist das Backup wertlos',
            ),
            _buildWarningItem(
              'Der Server-Betreiber könnte versuchen, das Passwort zu erraten',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _showBackupPasswordDialog();
            },
            child: const Text('Ich verstehe, fortfahren'),
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
          title: const Text('Backup-Passwort festlegen'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Wähle ein starkes Passwort für dein Backup. '
                  'Du brauchst es, um den Key wiederherzustellen.',
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Passwort',
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
                    labelText: 'Passwort bestätigen',
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
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () {
                final password = passwordController.text;
                final confirm = confirmController.text;

                if (password.length < 8) {
                  setDialogState(() {
                    error = 'Passwort muss mindestens 8 Zeichen haben';
                  });
                  return;
                }

                if (password != confirm) {
                  setDialogState(() {
                    error = 'Passwörter stimmen nicht überein';
                  });
                  return;
                }

                Navigator.pop(context);
                _uploadEncryptedBackup(password);
              },
              child: const Text('Backup erstellen'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadEncryptedBackup(String password) async {
    setState(() => _isLoading = true);

    try {
      final privateKey = await widget.pgpKeyService.getPrivateKey();
      if (privateKey == null) {
        throw Exception('Kein Private Key vorhanden');
      }

      final fingerprint = await widget.pgpKeyService.getFingerprint();
      if (fingerprint == null) {
        throw Exception('Kein Fingerprint vorhanden');
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Backup erfolgreich auf Server gespeichert!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('[PgpKeyScreen] Fehler beim Backup: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Backup: $e')),
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kein Backup auf dem Server gefunden.'),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Laden: $e')),
        );
      }
    }
  }

  void _showSelectBackupDialog(List<EncryptedKeyBackup> backups) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backup auswählen'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Wähle das Backup aus, das du wiederherstellen möchtest:',
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
                        'Erstellt: ${_formatBackupDate(backup.createdAt)}',
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
            child: const Text('Abbrechen'),
          ),
        ],
      ),
    );
  }

  void _showRestorePasswordDialog(EncryptedKeyBackup backup) {
    final passwordController = TextEditingController();
    bool obscurePassword = true;
    String? error;
    bool isRestoring = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Backup entschlüsseln'),
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
                const Text(
                  'Gib das Passwort ein, mit dem du das Backup verschlüsselt hast:',
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  enabled: !isRestoring,
                  decoration: InputDecoration(
                    labelText: 'Backup-Passwort',
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
                  const Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 12),
                      Text('Entschlüssele und importiere...'),
                    ],
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isRestoring ? null : () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: isRestoring
                  ? null
                  : () async {
                      final password = passwordController.text;

                      if (password.isEmpty) {
                        setDialogState(() {
                          error = 'Bitte gib das Passwort ein';
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
                          error = 'Entschlüsselung fehlgeschlagen. '
                              'Falsches Passwort?';
                        });
                      }
                    },
              child: const Text('Wiederherstellen'),
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
      throw Exception('Ungültiger Key nach Entschlüsselung');
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Schlüssel erfolgreich wiederhergestellt!'),
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

  String _formatBackupDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }

  void _showGenerateDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passphraseController = TextEditingController();
    bool usePassphrase = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Schlüssel generieren'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Dein Name',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-Mail (optional)',
                    hintText: 'deine@email.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: usePassphrase,
                  onChanged: (value) {
                    setDialogState(() => usePassphrase = value ?? false);
                  },
                  title: const Text('Mit Passphrase schützen'),
                  subtitle: const Text('Empfohlen für zusätzliche Sicherheit'),
                  contentPadding: EdgeInsets.zero,
                ),
                if (usePassphrase) ...[
                  const SizedBox(height: 8),
                  TextField(
                    controller: passphraseController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Passphrase',
                      hintText: 'Sichere Passphrase eingeben',
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () async {
                if (nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Bitte gib einen Namen ein')),
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
              child: const Text('Generieren'),
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Schlüssel erfolgreich generiert und hochgeladen!'),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler bei der Generierung: $e')),
        );
      }
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  void _showGeneratingProgressDialog() {
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
                'Schlüssel wird generiert...',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ed25519/Curve25519 Schlüssel wird erstellt.\n'
                'Dies dauert nur wenige Sekunden.',
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
    setState(() => _isLoading = true);

    try {
      final privateKey = await widget.pgpKeyService.getPrivateKey();
      if (privateKey == null) {
        throw Exception('Kein Private Key vorhanden');
      }

      final fingerprint = await widget.pgpKeyService.getFingerprint();
      if (fingerprint == null) {
        throw Exception('Kein Fingerprint vorhanden');
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Public Key erfolgreich hochgeladen!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('[PgpKeyScreen] Fehler beim Hochladen: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Hochladen: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showExportDialog() async {
    final privateKey = await widget.pgpKeyService.exportPrivateKey();

    if (privateKey == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kein Private Key vorhanden')),
        );
      }
      return;
    }

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Private Key Export'),
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
                        'Bewahre diesen Schlüssel sicher auf! '
                        'Teile ihn niemals mit anderen.',
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
            child: const Text('Schließen'),
          ),
          FilledButton.icon(
            onPressed: () {
              _copyToClipboard(privateKey, 'Private Key');
              Navigator.pop(context);
            },
            icon: const Icon(Icons.copy),
            label: const Text('Kopieren'),
          ),
        ],
      ),
    );
  }

  void _showImportDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Private Key importieren'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Füge deinen Private Key im PGP-Armor Format ein:',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: '-----BEGIN PGP PRIVATE KEY BLOCK-----\n...',
                  border: OutlineInputBorder(),
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
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bitte füge einen Key ein')),
                );
                return;
              }

              final success = await widget.pgpKeyService
                  .importPrivateKey(controller.text);

              if (mounted) {
                Navigator.pop(context);
                if (success) {
                  await _loadKeyStatus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Private Key erfolgreich importiert!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ungültiges Key-Format'),
                    ),
                  );
                }
              }
            },
            child: const Text('Importieren'),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label in die Zwischenablage kopiert')),
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

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
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
    final minutes = _seconds ~/ 60;
    final secs = _seconds % 60;
    return Text(
      'Verstrichene Zeit: ${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontFamily: 'monospace',
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
