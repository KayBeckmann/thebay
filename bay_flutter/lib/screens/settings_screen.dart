import 'package:flutter/material.dart';

import '../main.dart' show client;
import '../services/auth_service.dart';
import '../services/pgp_key_service.dart';
import '../services/user_preferences_service.dart';
import 'pgp_key_screen.dart';

/// Settings screen for user preferences and account management.
class SettingsScreen extends StatefulWidget {
  final AuthService authService;
  final PgpKeyService pgpKeyService;
  final VoidCallback onLogout;

  const SettingsScreen({
    super.key,
    required this.authService,
    required this.pgpKeyService,
    required this.onLogout,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _preferencesService = UserPreferencesService();

  // User preferences
  int _paginationSize = 25;
  String _currency = 'USD';

  // Payment info
  String? _paypalAddress;
  String? _bitcoinWallet;
  bool _isLoadingPaymentInfo = true;

  // PGP Key status
  bool _hasPgpKey = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadPgpKeyStatus(),
      _loadPaymentInfo(),
      _loadPreferences(),
    ]);
  }

  Future<void> _loadPreferences() async {
    try {
      final currency = await _preferencesService.getCurrency();
      final paginationSize = await _preferencesService.getPaginationSize();

      if (mounted) {
        setState(() {
          _currency = currency;
          _paginationSize = paginationSize;
        });
      }
    } catch (e) {
      // Ignore errors, use default values
    }
  }

  Future<void> _loadPgpKeyStatus() async {
    try {
      final status = await widget.pgpKeyService.getKeyStatus();
      if (mounted) {
        setState(() {
          _hasPgpKey = status.isFullyConfigured;
        });
      }
    } catch (e) {
      // Ignoriere Fehler beim Laden des Status
    }
  }

  Future<void> _loadPaymentInfo() async {
    try {
      final paymentInfo = await client.userProfile.getMyPaymentInfo();
      if (mounted) {
        setState(() {
          _paypalAddress = paymentInfo?.paypalAddress;
          _bitcoinWallet = paymentInfo?.bitcoinWallet;
          _isLoadingPaymentInfo = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingPaymentInfo = false;
        });
      }
    }
  }

  Future<void> _savePaymentInfo() async {
    try {
      await client.userProfile.updateMyPaymentInfo(
        paypalAddress: _paypalAddress,
        bitcoinWallet: _bitcoinWallet,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Speichern: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: ListView(
        children: [
          // Payment information section
          _buildSectionHeader(context, 'Zahlungsinformationen'),
          if (_isLoadingPaymentInfo)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            _buildPaymentInfoTile(
              context,
              icon: Icons.paypal,
              title: 'PayPal-Adresse',
              subtitle: _paypalAddress ?? 'Nicht angegeben',
              onTap: () => _editPaypalAddress(context),
            ),
            _buildPaymentInfoTile(
              context,
              icon: Icons.currency_bitcoin,
              title: 'Bitcoin-Wallet',
              subtitle: _bitcoinWallet ?? 'Nicht angegeben',
              onTap: () => _editBitcoinWallet(context),
            ),
          ],
          const Divider(),

          // Display preferences section
          _buildSectionHeader(context, 'Anzeige'),
          ListTile(
            leading: const Icon(Icons.format_list_numbered),
            title: const Text('Elemente pro Seite'),
            subtitle: Text('$_paginationSize Elemente'),
            onTap: () => _showPaginationDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Anzeigewährung'),
            subtitle: Text(_currency),
            onTap: () => _showCurrencyDialog(context),
          ),
          const Divider(),

          // Security section
          _buildSectionHeader(context, 'Sicherheit'),
          ListTile(
            leading: Icon(
              Icons.key,
              color: _hasPgpKey ? Colors.green : null,
            ),
            title: const Text('PGP-Schlüssel'),
            subtitle: Text(_hasPgpKey ? 'Eingerichtet' : 'Noch nicht eingerichtet'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openPgpKeyScreen(context),
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text('Passwort ändern'),
            onTap: () => _showChangePasswordDialog(context),
          ),
          const Divider(),

          // Account section
          _buildSectionHeader(context, 'Konto'),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Abmelden'),
            onTap: () => _confirmLogout(context),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.error),
            title: Text(
              'Konto löschen',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () => _confirmDeleteAccount(context),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildPaymentInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: subtitle == 'Nicht angegeben'
            ? TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)
            : null,
      ),
      trailing: const Icon(Icons.edit),
      onTap: onTap,
    );
  }

  void _editPaypalAddress(BuildContext context) {
    final controller = TextEditingController(text: _paypalAddress);
    bool isSaving = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('PayPal-Adresse'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'E-Mail-Adresse',
              hintText: 'deine@email.com',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: isSaving ? null : () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: isSaving
                  ? null
                  : () async {
                      setDialogState(() => isSaving = true);
                      setState(() {
                        _paypalAddress =
                            controller.text.isEmpty ? null : controller.text;
                      });
                      await _savePaymentInfo();
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('PayPal-Adresse gespeichert')),
                        );
                      }
                    },
              child: isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _editBitcoinWallet(BuildContext context) {
    final controller = TextEditingController(text: _bitcoinWallet);
    bool isSaving = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Bitcoin-Wallet'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Wallet-Adresse',
              hintText: 'bc1q...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: isSaving ? null : () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: isSaving
                  ? null
                  : () async {
                      setDialogState(() => isSaving = true);
                      setState(() {
                        _bitcoinWallet =
                            controller.text.isEmpty ? null : controller.text;
                      });
                      await _savePaymentInfo();
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Bitcoin-Wallet gespeichert')),
                        );
                      }
                    },
              child: isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaginationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Elemente pro Seite'),
        children: [10, 25, 50, 100].map((size) {
          return SimpleDialogOption(
            onPressed: () async {
              setState(() => _paginationSize = size);
              await _preferencesService.setPaginationSize(size);
              if (context.mounted) Navigator.pop(context);
            },
            child: Row(
              children: [
                if (_paginationSize == size)
                  Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                else
                  const SizedBox(width: 24),
                const SizedBox(width: 12),
                Text('$size Elemente'),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showCurrencyDialog(BuildContext context) {
    final currencies = ['USD', 'EUR', 'GBP', 'CHF', 'BTC'];

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Anzeigewährung'),
        children: currencies.map((currency) {
          return SimpleDialogOption(
            onPressed: () async {
              setState(() => _currency = currency);
              await _preferencesService.setCurrency(currency);
              if (context.mounted) Navigator.pop(context);
            },
            child: Row(
              children: [
                if (_currency == currency)
                  Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                else
                  const SizedBox(width: 24),
                const SizedBox(width: 12),
                Text(currency),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _openPgpKeyScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PgpKeyScreen(
          pgpKeyService: widget.pgpKeyService,
        ),
      ),
    );
    // Status nach Rückkehr aktualisieren
    _loadPgpKeyStatus();
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Passwort ändern'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Aktuelles Passwort',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Neues Passwort',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Passwort bestätigen',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (newPasswordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwörter stimmen nicht überein'),
                          ),
                        );
                        return;
                      }

                      setDialogState(() => isLoading = true);

                      try {
                        final response = await widget.authService.changePassword(
                          currentPassword: currentPasswordController.text,
                          newPassword: newPasswordController.text,
                        );

                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                response.success
                                    ? 'Passwort erfolgreich geändert'
                                    : response.errorMessage ?? 'Fehler beim Ändern des Passworts',
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          setDialogState(() => isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Fehler: $e')),
                          );
                        }
                      }
                    },
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Ändern'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Abmelden'),
        content: const Text('Möchtest du dich wirklich abmelden?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Abmelden'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.authService.logout();
      widget.onLogout();
    }
  }

  void _confirmDeleteAccount(BuildContext context) {
    final passwordController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          icon: Icon(Icons.warning, color: Theme.of(context).colorScheme.error),
          title: const Text('Konto löschen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Diese Aktion kann nicht rückgängig gemacht werden. '
                'Alle deine Daten werden unwiderruflich gelöscht.',
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Passwort zur Bestätigung',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bitte gib dein Passwort ein'),
                          ),
                        );
                        return;
                      }

                      setDialogState(() => isLoading = true);

                      try {
                        final response = await widget.authService
                            .deleteAccount(passwordController.text);

                        if (context.mounted) {
                          Navigator.pop(context);
                          if (response.success) {
                            widget.onLogout();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  response.errorMessage ?? 'Fehler beim Löschen des Kontos',
                                ),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          setDialogState(() => isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Fehler: $e')),
                          );
                        }
                      }
                    },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Konto löschen'),
            ),
          ],
        ),
      ),
    );
  }
}
