import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart' show client;
import 'transaction_detail_screen.dart';

/// Screen für die Transaktionsübersicht mit Tabs für Käufe und Verkäufe.
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Transaction> _purchases = [];
  List<Transaction> _sales = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadTransactions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadTransactions() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final purchases = await client.transaction.getMyTransactions(
        asBuyer: true,
        asSeller: false,
        limit: 100,
        offset: 0,
      );
      final sales = await client.transaction.getMyTransactions(
        asBuyer: false,
        asSeller: true,
        limit: 100,
        offset: 0,
      );

      if (mounted) {
        setState(() {
          _purchases = purchases;
          _sales = sales;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: const Icon(Icons.shopping_bag_outlined),
              text: 'Purchases (${_purchases.length})',
            ),
            Tab(
              icon: const Icon(Icons.sell_outlined),
              text: 'Sales (${_sales.length})',
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTransactions,
            tooltip: 'Refresh',
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
            Text('Error: $_error'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadTransactions,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _buildTransactionList(_purchases, isBuyer: true),
        _buildTransactionList(_sales, isBuyer: false),
      ],
    );
  }

  Widget _buildTransactionList(List<Transaction> transactions,
      {required bool isBuyer}) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isBuyer ? Icons.shopping_bag_outlined : Icons.sell_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              isBuyer ? 'No purchases yet' : 'No sales yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              isBuyer
                  ? 'Your purchases will appear here'
                  : 'Your sales will appear here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadTransactions,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return _TransactionCard(
            transaction: transactions[index],
            isBuyer: isBuyer,
            onTap: () => _openTransactionDetail(transactions[index]),
          );
        },
      ),
    );
  }

  void _openTransactionDetail(Transaction transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionDetailScreen(
          transactionId: transaction.id!,
          onStatusChanged: _loadTransactions,
        ),
      ),
    );
  }
}

/// Karte für eine einzelne Transaktion in der Liste.
class _TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final bool isBuyer;
  final VoidCallback onTap;

  const _TransactionCard({
    required this.transaction,
    required this.isBuyer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusInfo = _getStatusInfo(context, transaction.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Status und Datum
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusInfo.color.withAlpha(30),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: statusInfo.color),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusInfo.icon, size: 16, color: statusInfo.color),
                        const SizedBox(width: 6),
                        Text(
                          statusInfo.label,
                          style: TextStyle(
                            color: statusInfo.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _formatDate(transaction.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Transaktionsinfo
              Row(
                children: [
                  Icon(
                    isBuyer ? Icons.shopping_bag : Icons.sell,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaction #${transaction.id}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Listing #${transaction.listingId}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatPrice(transaction.totalPriceCents),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            transaction.paymentMethod == PaymentMethod.paypal
                                ? Icons.payment
                                : Icons.currency_bitcoin,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            transaction.paymentMethod == PaymentMethod.paypal
                                ? 'PayPal'
                                : 'Bitcoin',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // Auto-complete Warnung
              if (transaction.status == TransactionStatus.shipped &&
                  transaction.autoCompleteAt != null) ...[
                const SizedBox(height: 12),
                _buildAutoCompleteWarning(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAutoCompleteWarning(BuildContext context) {
    final daysLeft = transaction.autoCompleteAt!.difference(DateTime.now()).inDays;
    final isUrgent = daysLeft <= 3;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUrgent
            ? Theme.of(context).colorScheme.errorContainer
            : Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule,
            size: 18,
            color: isUrgent
                ? Theme.of(context).colorScheme.onErrorContainer
                : Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              daysLeft <= 0
                  ? 'Auto-completes today'
                  : 'Auto-completes in $daysLeft day${daysLeft == 1 ? '' : 's'}',
              style: TextStyle(
                color: isUrgent
                    ? Theme.of(context).colorScheme.onErrorContainer
                    : Theme.of(context).colorScheme.onTertiaryContainer,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _StatusInfo _getStatusInfo(BuildContext context, TransactionStatus status) {
    switch (status) {
      case TransactionStatus.open:
        return _StatusInfo(
          label: 'Open',
          icon: Icons.hourglass_empty,
          color: Colors.orange,
        );
      case TransactionStatus.paid:
        return _StatusInfo(
          label: 'Paid',
          icon: Icons.attach_money,
          color: Colors.green,
        );
      case TransactionStatus.shipped:
        return _StatusInfo(
          label: 'Shipped',
          icon: Icons.local_shipping,
          color: Colors.blue,
        );
      case TransactionStatus.received:
        return _StatusInfo(
          label: 'Received',
          icon: Icons.inbox,
          color: Colors.teal,
        );
      case TransactionStatus.completed:
        return _StatusInfo(
          label: 'Completed',
          icon: Icons.check_circle,
          color: Colors.green,
        );
      case TransactionStatus.disputed:
        return _StatusInfo(
          label: 'Disputed',
          icon: Icons.report_problem,
          color: Colors.red,
        );
      case TransactionStatus.cancelled:
        return _StatusInfo(
          label: 'Cancelled',
          icon: Icons.cancel,
          color: Colors.grey,
        );
    }
  }

  String _formatPrice(int cents) {
    return '\$${(cents / 100).toStringAsFixed(2)}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}

class _StatusInfo {
  final String label;
  final IconData icon;
  final Color color;

  _StatusInfo({
    required this.label,
    required this.icon,
    required this.color,
  });
}
