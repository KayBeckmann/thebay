import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
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
  String _language = 'en';

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
      final language = await _preferencesService.getLanguage();

      if (mounted) {
        setState(() {
          _currency = currency;
          _paginationSize = paginationSize;
          _language = language;
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
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorSaving(e.toString()))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
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
          _buildSectionHeader(context, l10n.sectionPaymentInfo),
          if (_isLoadingPaymentInfo)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            _buildPaymentInfoTile(
              context,
              icon: Icons.paypal,
              title: l10n.paypalAddress,
              subtitle: _paypalAddress ?? l10n.notSpecified,
              onTap: () => _editPaypalAddress(context),
            ),
            _buildPaymentInfoTile(
              context,
              icon: Icons.currency_bitcoin,
              title: l10n.bitcoinWallet,
              subtitle: _bitcoinWallet ?? l10n.notSpecified,
              onTap: () => _editBitcoinWallet(context),
            ),
          ],
          const Divider(),

          // Display preferences section
          _buildSectionHeader(context, l10n.sectionDisplay),
          ListTile(
            leading: const Icon(Icons.format_list_numbered),
            title: Text(l10n.itemsPerPage),
            subtitle: Text(l10n.itemsCount(_paginationSize)),
            onTap: () => _showPaginationDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: Text(l10n.displayCurrency),
            subtitle: Text(_currency),
            onTap: () => _showCurrencyDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(_languageLabel(context, _language)),
            onTap: () => _showLanguageDialog(context),
          ),
          const Divider(),

          // Security section
          _buildSectionHeader(context, l10n.sectionSecurity),
          ListTile(
            leading: Icon(
              Icons.key,
              color: _hasPgpKey ? Colors.green : null,
            ),
            title: Text(l10n.pgpKey),
            subtitle: Text(_hasPgpKey ? l10n.configured : l10n.notConfigured),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openPgpKeyScreen(context),
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: Text(l10n.changePassword),
            onTap: () => _showChangePasswordDialog(context),
          ),
          const Divider(),

          // Account section
          _buildSectionHeader(context, l10n.sectionAccount),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(l10n.logout),
            onTap: () => _confirmLogout(context),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.error),
            title: Text(
              l10n.deleteAccount,
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
    final l10n = AppLocalizations.of(context)!;
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: subtitle == l10n.notSpecified
            ? TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)
            : null,
      ),
      trailing: const Icon(Icons.edit),
      onTap: onTap,
    );
  }

  void _editPaypalAddress(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: _paypalAddress);
    bool isSaving = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.paypalAddress),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: l10n.emailAddress,
              hintText: l10n.emailHint,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: isSaving ? null : () => Navigator.pop(context),
              child: Text(l10n.cancel),
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
                          SnackBar(
                              content: Text(l10n.paypalAddressSaved)),
                        );
                      }
                    },
              child: isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  void _editBitcoinWallet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: _bitcoinWallet);
    bool isSaving = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.bitcoinWallet),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: l10n.walletAddress,
              hintText: l10n.walletHint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: isSaving ? null : () => Navigator.pop(context),
              child: Text(l10n.cancel),
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
                          SnackBar(
                              content: Text(l10n.bitcoinWalletSaved)),
                        );
                      }
                    },
              child: isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaginationDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.itemsPerPage),
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
                Text(l10n.itemsCount(size)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showCurrencyDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currencies = ['USD', 'EUR', 'GBP', 'CHF', 'BTC'];

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.displayCurrency),
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

  void _showLanguageDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languages = {
      'en': l10n.langEnglish,
      'de': l10n.langGerman,
      'fr': l10n.langFrench,
      'es': l10n.langSpanish,
    };

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.language),
        children: languages.entries.map((entry) {
          return SimpleDialogOption(
            onPressed: () async {
              setState(() => _language = entry.key);
              await _preferencesService.setLanguage(entry.key);
              if (context.mounted) {
                Navigator.pop(context);
                // Show message to restart app for language change
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.languageChanged),
                    duration: const Duration(seconds: 4),
                  ),
                );
              }
            },
            child: Row(
              children: [
                if (_language == entry.key)
                  Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                else
                  const SizedBox(width: 24),
                const SizedBox(width: 12),
                Text(entry.value),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _languageLabel(BuildContext context, String code) {
    final l10n = AppLocalizations.of(context)!;
    switch (code) {
      case 'de':
        return l10n.langGerman;
      case 'fr':
        return l10n.langFrench;
      case 'es':
        return l10n.langSpanish;
      case 'en':
      default:
        return l10n.langEnglish;
    }
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
    final l10n = AppLocalizations.of(context)!;
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.changePassword),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: l10n.currentPassword,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: l10n.newPassword,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: l10n.confirmPassword,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (newPasswordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.passwordsMismatch),
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
                                    ? l10n.passwordChangeSuccess
                                    : response.errorMessage ?? l10n.passwordChangeError,
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          setDialogState(() => isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.genericError(e.toString()))),
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
                  : Text(l10n.changeButton),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.logout),
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
    final l10n = AppLocalizations.of(context)!;
    final passwordController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          icon: Icon(Icons.warning, color: Theme.of(context).colorScheme.error),
          title: Text(l10n.deleteAccount),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.deleteAccountWarning),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: l10n.passwordConfirmation,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.pleaseEnterPassword),
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
                                  response.errorMessage ?? l10n.deleteAccountError,
                                ),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          setDialogState(() => isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.genericError(e.toString()))),
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
                  : Text(l10n.deleteAccount),
            ),
          ],
        ),
      ),
    );
  }
}
