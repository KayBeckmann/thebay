import 'package:flutter/material.dart';

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
          _paypalEmail = (settings['paypalEmail'] as String?) ?? '';
          _bitcoinWallet = (settings['bitcoinWallet'] as String?) ?? '';
          _paypalEnabled = (settings['paypalEnabled'] as bool?) ?? false;
          _bitcoinEnabled = (settings['bitcoinEnabled'] as bool?) ?? false;

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
          const SnackBar(content: Text('Einstellungen gespeichert')),
        );
        _loadSettings();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zahlungseinstellungen'),
        actions: [
          if (!_isLoading)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveSettings,
              tooltip: 'Speichern',
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text('Fehler: $_error'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadSettings,
              child: const Text('Erneut versuchen'),
            ),
          ],
        ),
      );
    }

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
                    'Diese Einstellungen bestimmen, wie Benutzer für Slots bezahlen können.',
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
                  title: const Text('PayPal aktivieren'),
                  subtitle: const Text('Benutzer können mit PayPal bezahlen'),
                  value: _paypalEnabled,
                  onChanged: (value) => setState(() => _paypalEnabled = value),
                ),
                const Divider(),
                TextField(
                  controller: _paypalController,
                  decoration: const InputDecoration(
                    labelText: 'PayPal E-Mail-Adresse',
                    hintText: 'zahlungen@beispiel.com',
                    prefixIcon: Icon(Icons.email),
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
                  title: const Text('Bitcoin aktivieren'),
                  subtitle: const Text('Benutzer können mit Bitcoin bezahlen'),
                  value: _bitcoinEnabled,
                  onChanged: (value) => setState(() => _bitcoinEnabled = value),
                ),
                const Divider(),
                TextField(
                  controller: _bitcoinController,
                  decoration: const InputDecoration(
                    labelText: 'Bitcoin Wallet-Adresse',
                    hintText: 'bc1q...',
                    prefixIcon: Icon(Icons.currency_bitcoin),
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
          label: const Text('Einstellungen speichern'),
        ),
      ],
    );
  }
}
