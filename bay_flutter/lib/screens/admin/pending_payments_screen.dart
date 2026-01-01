import 'package:flutter/material.dart';

import 'package:bay_client/bay_client.dart';

import '../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final paymentMethodName = order.paymentMethod == PaymentMethod.paypal ? 'PayPal' : 'Bitcoin';
    final amountFormatted = '\$${(order.amountCents / 100).toStringAsFixed(2)}';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmPaymentTitle),
        content: Text(
          l10n.confirmPaymentMessage(order.id!, amountFormatted, paymentMethodName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await client.payment.confirmPaymentManually(orderId: order.id!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.paymentConfirmedSlotActivated)),
        );
        _loadPendingOrders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorLoading(e.toString()))),
        );
      }
    }
  }

  Future<void> _checkBitcoinPayments() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    try {
      final count = await client.payment.checkPendingBitcoinPayments();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.bitcoinPaymentsProcessed(count))),
        );
        _loadPendingOrders();
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

  Future<void> _expireOldOrders() async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.expireOldOrdersTitle),
        content: Text(l10n.expireOldOrdersMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.expireAction),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final count = await client.slotOrder.expireOldOrders();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.ordersExpired(count))),
        );
        _loadPendingOrders();
      }
    } catch (e) {
      if (mounted) {
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
        title: Text(l10n.pendingPaymentsScreen),
        actions: [
          IconButton(
            icon: const Icon(Icons.currency_bitcoin),
            onPressed: _checkBitcoinPayments,
            tooltip: l10n.checkBitcoinPayments,
          ),
          IconButton(
            icon: const Icon(Icons.timer_off),
            onPressed: _expireOldOrders,
            tooltip: l10n.expireOldOrders,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPendingOrders,
            tooltip: l10n.refresh,
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
              onPressed: _loadPendingOrders,
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    if (_pendingOrders.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
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
              l10n.noPendingPayments,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.allPaymentsProcessed,
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
    final l10n = AppLocalizations.of(context)!;
    final user = _users[order.id];
    final variant = _variants[order.id];

    final isOld =
        DateTime.now().difference(order.createdAt).inHours > 24;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isOld ? Theme.of(context).colorScheme.errorContainer : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => _showPaymentDetails(order),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
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
                              l10n.orderNumber(order.id!),
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
                    l10n.user,
                    user?.username ?? l10n.unknown,
                    Icons.person,
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow(
                    context,
                    l10n.variant,
                    variant?.name ?? l10n.unknown,
                    Icons.confirmation_number,
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow(
                    context,
                    l10n.amount,
                    '\$${(order.amountCents / 100).toStringAsFixed(2)}',
                    Icons.attach_money,
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow(
                    context,
                    l10n.method,
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
                      l10n.txId,
                      order.transactionId!,
                      Icons.tag,
                    ),
                  ],

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: FilledButton.icon(
                onPressed: () => _confirmPayment(order),
                icon: const Icon(Icons.check),
                label: Text(l10n.confirm),
              ),
            ),
          ),
        ],
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
    final l10n = AppLocalizations.of(context)!;

    try {
      final info = await client.payment.getPaymentInfo(order.id!);

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.paymentDetailsTitle(order.id!)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (order.paymentMethod == PaymentMethod.paypal) ...[
                  _buildInfoItem(l10n.paypalEmail, info['email'] ?? '-'),
                  _buildInfoItem(l10n.amount, '\$${info['amount']}'),
                  _buildInfoItem(l10n.currency, info['currency'] ?? 'USD'),
                ] else ...[
                  _buildInfoItem(l10n.bitcoinAddress, info['address'] ?? '-'),
                  _buildInfoItem(l10n.amountUsd, '\$${info['amountUsd']}'),
                  _buildInfoItem(
                      l10n.amountBtc, '${info['amountBtc']} BTC'),
                  _buildInfoItem(l10n.memo, info['memo'] ?? '-'),
                ],
                _buildInfoItem(l10n.description, info['description'] ?? '-'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.close),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorLoading(e.toString()))),
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
