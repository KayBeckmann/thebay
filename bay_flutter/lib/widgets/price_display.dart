import 'package:flutter/material.dart';
import 'package:bay_client/bay_client.dart';

import '../main.dart' show client;
import '../services/currency_service.dart';

/// Widget to display price with optional currency conversion
class PriceDisplay extends StatefulWidget {
  final int priceInCents;
  final String priceCurrency;
  final String? userCurrency; // If null, no conversion
  final TextStyle? style;
  final bool showOriginal;
  final bool compact; // If true, shows shorter format

  const PriceDisplay({
    super.key,
    required this.priceInCents,
    required this.priceCurrency,
    this.userCurrency,
    this.style,
    this.showOriginal = false,
    this.compact = false,
  });

  @override
  State<PriceDisplay> createState() => _PriceDisplayState();
}

class _PriceDisplayState extends State<PriceDisplay> {
  late CurrencyService _currencyService;
  String? _displayText;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _currencyService = CurrencyService(client);
    _loadPrice();
  }

  @override
  void didUpdateWidget(PriceDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reload if price or currencies changed
    if (oldWidget.priceInCents != widget.priceInCents ||
        oldWidget.priceCurrency != widget.priceCurrency ||
        oldWidget.userCurrency != widget.userCurrency) {
      _loadPrice();
    }
  }

  Future<void> _loadPrice() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // If no user currency or same as price currency, just format
      if (widget.userCurrency == null ||
          widget.userCurrency!.toUpperCase() == widget.priceCurrency.toUpperCase()) {
        final formatted = _currencyService.formatPrice(
          priceInCents: widget.priceInCents,
          currency: widget.priceCurrency,
        );

        if (mounted) {
          setState(() {
            _displayText = formatted;
            _isLoading = false;
          });
        }
        return;
      }

      // Convert and format
      final formatted = await _currencyService.formatPriceWithConversion(
        priceInCents: widget.priceInCents,
        priceCurrency: widget.priceCurrency,
        userCurrency: widget.userCurrency!,
        showOriginal: widget.showOriginal,
      );

      if (mounted) {
        setState(() {
          _displayText = formatted;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
          // Fallback to original price
          _displayText = _currencyService.formatPrice(
            priceInCents: widget.priceInCents,
            currency: widget.priceCurrency,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        width: widget.compact ? 40 : 60,
        height: 12,
        child: const LinearProgressIndicator(),
      );
    }

    return Text(
      _displayText ?? '-',
      style: widget.style,
    );
  }
}

/// Widget to display price per unit with unit label
class PricePerUnitDisplay extends StatelessWidget {
  final int priceInCents;
  final String priceCurrency;
  final QuantityUnit quantityUnit;
  final String? userCurrency;
  final TextStyle? priceStyle;
  final TextStyle? unitStyle;
  final bool showOriginal;

  const PricePerUnitDisplay({
    super.key,
    required this.priceInCents,
    required this.priceCurrency,
    required this.quantityUnit,
    this.userCurrency,
    this.priceStyle,
    this.unitStyle,
    this.showOriginal = false,
  });

  String _getQuantityUnitLabel(QuantityUnit unit) {
    switch (unit) {
      case QuantityUnit.piece:
        return 'Stück';
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

  @override
  Widget build(BuildContext context) {
    final unitLabel = _getQuantityUnitLabel(quantityUnit);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        PriceDisplay(
          priceInCents: priceInCents,
          priceCurrency: priceCurrency,
          userCurrency: userCurrency,
          style: priceStyle,
          showOriginal: showOriginal,
        ),
        if (unitLabel.isNotEmpty) ...[
          Text(
            ' / $unitLabel',
            style: unitStyle,
          ),
        ],
      ],
    );
  }
}
