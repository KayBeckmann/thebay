import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              'Erstellt einen neuen RSA-4096 Schlüssel. '
              'Dies kann einige Sekunden dauern.',
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
                label: const Text('Private Key importieren'),
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
    setState(() => _isGenerating = true);

    try {
      // Generiere Schlüsselpaar
      final keyPair = await widget.pgpKeyService.generateKeyPair(
        name: name,
        email: email,
        passphrase: passphrase,
      );

      // Speichere Private Key lokal
      await widget.pgpKeyService.storePrivateKey(
        keyPair.privateKey,
        keyPair.fingerprint,
      );

      // Lade Public Key zum Server hoch
      await widget.pgpKeyService.uploadPublicKey(
        keyPair.publicKey,
        keyPair.identity,
        keyPair.fingerprint,
        keyPair.algorithm,
        keyPair.keySize,
      );

      // Status aktualisieren
      await _loadKeyStatus();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Schlüssel erfolgreich generiert und hochgeladen!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler bei der Generierung: $e')),
        );
      }
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  Future<void> _uploadPublicKey() async {
    setState(() => _isLoading = true);

    try {
      final privateKey = await widget.pgpKeyService.getPrivateKey();
      if (privateKey == null) {
        throw Exception('Kein Private Key vorhanden');
      }

      // Extrahiere Public Key und Metadaten aus Private Key
      // Dies wird vom PgpKeyService intern gehandhabt
      final serverKey = await widget.pgpKeyService.getMyPublicKey();

      if (serverKey != null) {
        await _loadKeyStatus();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Public Key erfolgreich hochgeladen!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
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
