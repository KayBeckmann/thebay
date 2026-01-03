import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
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

  String _getQuantityUnitLabel(QuantityUnit unit, AppLocalizations l10n) {
    switch (unit) {
      case QuantityUnit.piece:
        return l10n.quantityUnitPiece;
      case QuantityUnit.kg:
        return l10n.quantityUnitKg;
      case QuantityUnit.gram:
        return l10n.quantityUnitGram;
      case QuantityUnit.meter:
        return l10n.quantityUnitMeter;
      case QuantityUnit.liter:
        return l10n.quantityUnitLiter;
      case QuantityUnit.none:
        return '';
    }
  }

  String _formatPrice(int cents) {
    return '\$${(cents / 100).toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final unitLabel = _getQuantityUnitLabel(widget.listing.quantityUnit, l10n);

    return AlertDialog(
      title: Text(l10n.startTransaction),
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
                          l10n.pricePerUnit(
                            _formatPrice(widget.listing.pricePerUnit),
                            unitLabel,
                          ),
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
              l10n.quantityLabel,
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
                      hintText: l10n.enterQuantity,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.ofAvailable(widget.listing.quantity.toString()),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Note Input
            Text(
              l10n.noteForSeller,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: l10n.noteForSellerHint,
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
                    l10n.subtotal,
                    _formatPrice(_totalCents),
                    context,
                  ),
                  if (widget.listing.hasShipping) ...[
                    const SizedBox(height: 4),
                    _buildPriceRow(
                      l10n.shipping,
                      _formatPrice(_shippingCents),
                      context,
                    ),
                  ],
                  const Divider(height: 16),
                  _buildPriceRow(
                    l10n.total,
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
                    l10n.paymentVia(
                      widget.listing.acceptsPaypal && widget.listing.acceptsBitcoin
                          ? l10n.paymentMethodPaypalOrBitcoin
                          : widget.listing.acceptsPaypal
                              ? l10n.paymentMethodPaypal
                              : l10n.paymentMethodBitcoin,
                    ),
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
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _isLoading || _quantity <= 0 ? null : _startTransaction,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.startTransaction),
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
    final l10n = AppLocalizations.of(context)!;

    // Validate quantity
    if (_quantity <= 0) {
      setState(() => _error = l10n.enterValidQuantity);
      return;
    }
    if (_quantity > widget.listing.quantity) {
      setState(() => _error = l10n.quantityExceedsAvailable);
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
