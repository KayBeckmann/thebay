import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart';

/// Admin screen for managing payment settings.
class PaymentSettingsScreen extends StatefulWidget {
  const PaymentSettingsScreen({super.key});

  @override
  State<PaymentSettingsScreen> createState() => _PaymentSettingsScreenState();
}

class _PaymentSettingsScreenState extends State<PaymentSettingsScreen> {
  bool _isLoading = true;
  String? _error;

  // Payment settings
  String _paypalEmail = '';
  String _bitcoinWallet = '';
  bool _paypalEnabled = false;
  bool _bitcoinEnabled = false;

  final _paypalController = TextEditingController();
  final _bitcoinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _paypalController.dispose();
    _bitcoinController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final settings = await client.settings.getPaymentSettings();
      if (mounted) {
        setState(() {
          _paypalEmail = settings['paypalEmail'] ?? '';
          _bitcoinWallet = settings['bitcoinWallet'] ?? '';
          _paypalEnabled = settings['paypalEnabled'] == 'true';
          _bitcoinEnabled = settings['bitcoinEnabled'] == 'true';

          _paypalController.text = _paypalEmail;
          _bitcoinController.text = _bitcoinWallet;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _saveSettings() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    try {
      await client.settings.updatePaymentSettings(
        paypalEmail: _paypalController.text.trim(),
        bitcoinWallet: _bitcoinController.text.trim(),
        paypalEnabled: _paypalEnabled,
        bitcoinEnabled: _bitcoinEnabled,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.settingsSaved)),
        );
        _loadSettings();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
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
        title: Text(l10n.paymentSettingsScreen),
        actions: [
          if (!_isLoading)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveSettings,
              tooltip: l10n.save,
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(l10n.errorLoading(_error!)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadSettings,
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Info card
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.info_outline,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.paymentSettingsInfo,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // PayPal section
        Text(
          'PayPal',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(l10n.enablePaypal),
                  subtitle: Text(l10n.paypalPaymentDescription),
                  value: _paypalEnabled,
                  onChanged: (value) => setState(() => _paypalEnabled = value),
                ),
                const Divider(),
                TextField(
                  controller: _paypalController,
                  decoration: InputDecoration(
                    labelText: l10n.paypalEmailAddress,
                    hintText: l10n.paypalEmailHint,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  enabled: _paypalEnabled,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Bitcoin section
        Text(
          'Bitcoin',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(l10n.enableBitcoin),
                  subtitle: Text(l10n.bitcoinPaymentDescription),
                  value: _bitcoinEnabled,
                  onChanged: (value) => setState(() => _bitcoinEnabled = value),
                ),
                const Divider(),
                TextField(
                  controller: _bitcoinController,
                  decoration: InputDecoration(
                    labelText: l10n.bitcoinWalletAddress,
                    hintText: l10n.bitcoinWalletHint,
                    prefixIcon: const Icon(Icons.currency_bitcoin),
                  ),
                  enabled: _bitcoinEnabled,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Save button
        FilledButton.icon(
          onPressed: _saveSettings,
          icon: const Icon(Icons.save),
          label: Text(l10n.saveSettings),
        ),
      ],
    );
  }
}
