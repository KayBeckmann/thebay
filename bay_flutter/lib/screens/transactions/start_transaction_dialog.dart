import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart' show client;
import 'transaction_detail_screen.dart';

/// Dialog zum Starten einer neuen Transaktion (Kauf eines Angebots).
Future<Transaction?> showStartTransactionDialog(
  BuildContext context, {
  required Listing listing,
}) async {
  return showDialog<Transaction>(
    context: context,
    builder: (context) => _StartTransactionDialog(listing: listing),
  );
}

class _StartTransactionDialog extends StatefulWidget {
  final Listing listing;

  const _StartTransactionDialog({required this.listing});

  @override
  State<_StartTransactionDialog> createState() =>
      _StartTransactionDialogState();
}

class _StartTransactionDialogState extends State<_StartTransactionDialog> {
  final _quantityController = TextEditingController(text: '1');
  final _noteController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  double get _quantity => double.tryParse(_quantityController.text) ?? 0;
  int get _totalCents => (widget.listing.pricePerUnit * _quantity).round();
  int get _shippingCents => widget.listing.shippingCostCents ?? 0;
  int get _grandTotalCents => _totalCents + _shippingCents;

  @override
  void dispose() {
    _quantityController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String _getQuantityUnitLabel(QuantityUnit unit) {
    switch (unit) {
      case QuantityUnit.piece:
        return 'pieces';
      case QuantityUnit.kg:
        return 'kg';
      case QuantityUnit.gram:
        return 'g';
      case QuantityUnit.meter:
        return 'm';
      case QuantityUnit.liter:
        return 'L';
      case QuantityUnit.none:
        return '';
    }
  }

  String _formatPrice(int cents) {
    return '\$${(cents / 100).toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final unitLabel = _getQuantityUnitLabel(widget.listing.quantityUnit);

    return AlertDialog(
      title: const Text('Start Transaction'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Listing Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.inventory_2,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.listing.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_formatPrice(widget.listing.pricePerUnit)} per $unitLabel',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Quantity Input
            Text(
              'Quantity',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffixText: unitLabel,
                      hintText: 'Enter quantity',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'of ${widget.listing.quantity}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Note Input
            Text(
              'Note for seller (optional)',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a note for the seller...',
              ),
              maxLines: 2,
              maxLength: 500,
            ),
            const SizedBox(height: 16),

            // Price Summary
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildPriceRow(
                    'Subtotal',
                    _formatPrice(_totalCents),
                    context,
                  ),
                  if (widget.listing.hasShipping) ...[
                    const SizedBox(height: 4),
                    _buildPriceRow(
                      'Shipping',
                      _formatPrice(_shippingCents),
                      context,
                    ),
                  ],
                  const Divider(height: 16),
                  _buildPriceRow(
                    'Total',
                    _formatPrice(_grandTotalCents),
                    context,
                    isBold: true,
                  ),
                ],
              ),
            ),

            // Payment Method Info
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Payment via ${widget.listing.acceptsPaypal && widget.listing.acceptsBitcoin ? 'PayPal or Bitcoin' : widget.listing.acceptsPaypal ? 'PayPal' : 'Bitcoin'}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ],
            ),

            // Error
            if (_error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading || _quantity <= 0 ? null : _startTransaction,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Start Transaction'),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, BuildContext context,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }

  Future<void> _startTransaction() async {
    // Validate quantity
    if (_quantity <= 0) {
      setState(() => _error = 'Please enter a valid quantity');
      return;
    }
    if (_quantity > widget.listing.quantity) {
      setState(() => _error = 'Quantity exceeds available amount');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final transaction = await client.transaction.create(
        listingId: widget.listing.id!,
        quantity: _quantity,
        buyerNote: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context, transaction);

        // Navigate to transaction detail
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailScreen(
              transactionId: transaction.id!,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString().replaceAll('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }
}
