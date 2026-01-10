import 'dart:typed_data';

import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../../widgets/price_display.dart';
import 'listing_detail_screen.dart';

/// Kompakte Karte für ein Angebot in Listen.
class ListingCard extends StatelessWidget {
  final Listing listing;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;
  final String? userCurrency;

  const ListingCard({
    super.key,
    required this.listing,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.showActions = false,
    this.userCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () => _openDetail(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bild
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _ListingImageWidget(listingId: listing.id!),
            ),

            // Inhalt
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titel
                  Text(
                    listing.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Preis
                  PricePerUnitDisplay(
                    priceInCents: listing.pricePerUnit,
                    priceCurrency: listing.acceptsBitcoin && !listing.acceptsPaypal ? 'BTC' : 'USD',
                    quantityUnit: listing.quantityUnit,
                    userCurrency: userCurrency,
                    priceStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                    unitStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Badges
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      if (listing.hasShipping)
                        _buildBadge(context, Icons.local_shipping, l10n.shipping),
                      if (listing.acceptsPaypal)
                        _buildBadge(context, Icons.payment, l10n.paypal),
                      if (listing.acceptsBitcoin)
                        _buildBadge(context, Icons.currency_bitcoin, 'BTC'),
                      if (!listing.isActive)
                        _buildBadge(
                          context,
                          Icons.visibility_off,
                          l10n.inactive,
                          color: Theme.of(context).colorScheme.error,
                        ),
                    ],
                  ),

                  // Aktionen
                  if (showActions) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (onEdit != null)
                          TextButton.icon(
                            onPressed: onEdit,
                            icon: const Icon(Icons.edit, size: 18),
                            label: Text(l10n.edit),
                          ),
                        if (onDelete != null)
                          TextButton.icon(
                            onPressed: onDelete,
                            icon: Icon(
                              Icons.delete,
                              size: 18,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            label: Text(
                              l10n.delete,
                              style: TextStyle(color: Theme.of(context).colorScheme.error),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, IconData icon, String label, {Color? color}) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: effectiveColor.withAlpha(26),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: effectiveColor),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: effectiveColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListingDetailScreen(listingId: listing.id!),
      ),
    );
  }
}

/// Widget zum Laden und Anzeigen des ersten Bildes eines Listings.
class _ListingImageWidget extends StatefulWidget {
  final int listingId;

  const _ListingImageWidget({required this.listingId});

  @override
  State<_ListingImageWidget> createState() => _ListingImageWidgetState();
}

class _ListingImageWidgetState extends State<_ListingImageWidget> {
  Uint8List? _imageData;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final images = await client.listingImage.getByListing(widget.listingId);
      if (images.isNotEmpty && mounted) {
        final byteData = await client.listingImage.getImageData(images.first.id!);
        if (mounted) {
          setState(() {
            _imageData = byteData?.buffer.asUint8List();
            _isLoading = false;
            _hasError = _imageData == null;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _hasError = true;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_hasError || _imageData == null) {
      return Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            size: 48,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Image.memory(
      _imageData!,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}

/// Kompakte horizontale Listenansicht für Angebote.
class ListingListTile extends StatelessWidget {
  final Listing listing;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final String? userCurrency;

  const ListingListTile({
    super.key,
    required this.listing,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.userCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: ListTile(
        onTap: onTap ??
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListingDetailScreen(listingId: listing.id!),
                  ),
                ),
        leading: SizedBox(
          width: 56,
          height: 56,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _ListingImageWidget(listingId: listing.id!),
          ),
        ),
        title: Text(
          listing.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: PriceDisplay(
          priceInCents: listing.pricePerUnit,
          priceCurrency: listing.acceptsBitcoin && !listing.acceptsPaypal ? 'BTC' : 'USD',
          userCurrency: userCurrency,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          compact: true,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!listing.isActive)
              Icon(Icons.visibility_off, color: Theme.of(context).colorScheme.error),
            if (onEdit != null || onDelete != null)
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') onEdit?.call();
                  if (value == 'delete') onDelete?.call();
                },
                itemBuilder: (context) => [
                  if (onEdit != null)
                    PopupMenuItem(value: 'edit', child: Text(l10n.edit)),
                  if (onDelete != null)
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        l10n.delete,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
