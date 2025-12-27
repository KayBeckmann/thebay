import 'package:flutter/material.dart';

import 'package:bay_client/bay_client.dart';

import '../../main.dart';

/// Admin screen for managing pending payments.
class PendingPaymentsScreen extends StatefulWidget {
  const PendingPaymentsScreen({super.key});

  @override
  State<PendingPaymentsScreen> createState() => _PendingPaymentsScreenState();
}

class _PendingPaymentsScreenState extends State<PendingPaymentsScreen> {
  bool _isLoading = true;
  String? _error;
  List<SlotOrder> _pendingOrders = [];
  final Map<int, User?> _users = {};
  final Map<int, SlotVariant?> _variants = {};

  @override
  void initState() {
    super.initState();
    _loadPendingOrders();
  }

  Future<void> _loadPendingOrders() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final orders = await client.slotOrder.getAllPendingOrders();

      // Load user and variant info for each order
      for (final order in orders) {
        if (!_users.containsKey(order.id)) {
          _users[order.id!] = await client.slotOrder.getOrderUser(order.id!);
        }
        if (!_variants.containsKey(order.id)) {
          _variants[order.id!] =
              await client.slotOrder.getOrderVariant(order.id!);
        }
      }

      if (mounted) {
        setState(() {
          _pendingOrders = orders;
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

  Future<void> _confirmPayment(SlotOrder order) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Zahlung bestätigen'),
        content: Text(
          'Möchten Sie die Zahlung für Bestellung #${order.id} wirklich bestätigen?\n\n'
          'Betrag: \$${(order.amountCents / 100).toStringAsFixed(2)}\n'
          'Methode: ${order.paymentMethod == PaymentMethod.paypal ? 'PayPal' : 'Bitcoin'}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Bestätigen'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await client.payment.confirmPaymentManually(orderId: order.id!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Zahlung bestätigt und Slot aktiviert')),
        );
        _loadPendingOrders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    }
  }

  Future<void> _checkBitcoinPayments() async {
    setState(() => _isLoading = true);

    try {
      final count = await client.payment.checkPendingBitcoinPayments();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$count Bitcoin-Zahlungen verarbeitet')),
        );
        _loadPendingOrders();
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

  Future<void> _expireOldOrders() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alte Bestellungen ablaufen lassen'),
        content: const Text(
          'Möchten Sie alle ausstehenden Bestellungen, die älter als 24 Stunden sind, '
          'als abgelaufen markieren?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ablaufen lassen'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final count = await client.slotOrder.expireOldOrders();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$count Bestellungen als abgelaufen markiert')),
        );
        _loadPendingOrders();
      }
    } catch (e) {
      if (mounted) {
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
        title: const Text('Ausstehende Zahlungen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.currency_bitcoin),
            onPressed: _checkBitcoinPayments,
            tooltip: 'Bitcoin-Zahlungen prüfen',
          ),
          IconButton(
            icon: const Icon(Icons.timer_off),
            onPressed: _expireOldOrders,
            tooltip: 'Alte Bestellungen ablaufen lassen',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPendingOrders,
            tooltip: 'Aktualisieren',
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
              onPressed: _loadPendingOrders,
              child: const Text('Erneut versuchen'),
            ),
          ],
        ),
      );
    }

    if (_pendingOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Keine ausstehenden Zahlungen',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Alle Zahlungen wurden verarbeitet',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadPendingOrders,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _pendingOrders.length,
        itemBuilder: (context, index) {
          final order = _pendingOrders[index];
          return _buildOrderCard(order);
        },
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildOrderCard(SlotOrder order) {
    final user = _users[order.id];
    final variant = _variants[order.id];

    final isOld =
        DateTime.now().difference(order.createdAt).inHours > 24;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isOld ? Theme.of(context).colorScheme.errorContainer : null,
      child: InkWell(
        onTap: () => _showPaymentDetails(order),
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: Icon(
                          order.paymentMethod == PaymentMethod.paypal
                              ? Icons.paypal
                              : Icons.currency_bitcoin,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bestellung #${order.id}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              _formatDateTime(order.createdAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (isOld)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '>24h',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Details
                  _buildDetailRow(
                    context,
                    'Benutzer',
                    user?.username ?? 'Unbekannt',
                    Icons.person,
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow(
                    context,
                    'Variante',
                    variant?.name ?? 'Unbekannt',
                    Icons.confirmation_number,
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow(
                    context,
                    'Betrag',
                    '\$${(order.amountCents / 100).toStringAsFixed(2)}',
                    Icons.attach_money,
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow(
                    context,
                    'Methode',
                    order.paymentMethod == PaymentMethod.paypal
                        ? 'PayPal'
                        : 'Bitcoin',
                    order.paymentMethod == PaymentMethod.paypal
                        ? Icons.paypal
                        : Icons.currency_bitcoin,
                  ),

                  if (order.transactionId != null &&
                      order.transactionId!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      context,
                      'TX-ID',
                      order.transactionId!,
                      Icons.tag,
                    ),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: FilledButton.icon(
                onPressed: () => _confirmPayment(order),
                icon: const Icon(Icons.check),
                label: const Text('Bestätigen'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Future<void> _showPaymentDetails(SlotOrder order) async {
    try {
      final info = await client.payment.getPaymentInfo(order.id!);

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Zahlungsdetails #${order.id}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (order.paymentMethod == PaymentMethod.paypal) ...[
                  _buildInfoItem('PayPal E-Mail', info['email'] ?? '-'),
                  _buildInfoItem('Betrag', '\$${info['amount']}'),
                  _buildInfoItem('Währung', info['currency'] ?? 'USD'),
                ] else ...[
                  _buildInfoItem('Bitcoin-Adresse', info['address'] ?? '-'),
                  _buildInfoItem('Betrag (USD)', '\$${info['amountUsd']}'),
                  _buildInfoItem(
                      'Betrag (BTC)', '${info['amountBtc']} BTC'),
                  _buildInfoItem('Memo', info['memo'] ?? '-'),
                ],
                _buildInfoItem('Beschreibung', info['description'] ?? '-'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Schließen'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    }
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
