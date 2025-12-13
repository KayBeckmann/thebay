import 'dart:typed_data';

import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

/// Detailansicht für ein Angebot.
class ListingDetailScreen extends StatefulWidget {
  final int listingId;

  const ListingDetailScreen({super.key, required this.listingId});

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  Listing? _listing;
  List<ListingImage> _images = [];
  Category? _category;
  bool _isLoading = true;
  String? _error;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final listing = await client.listing.getById(widget.listingId);
      if (listing == null) {
        throw Exception('Angebot nicht gefunden');
      }

      final images = await client.listingImage.getByListing(widget.listingId);
      final categories = await client.category.getAll();
      final category = categories.firstWhere(
        (c) => c.id == listing.categoryId,
        orElse: () => categories.first,
      );

      if (mounted) {
        setState(() {
          _listing = listing;
          _images = images;
          _category = category;
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

  String _formatPrice(int cents) {
    return '\$${(cents / 100).toStringAsFixed(2)}';
  }

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
    return Scaffold(
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
            Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text('Fehler: $_error'),
            const SizedBox(height: 16),
            FilledButton(onPressed: _loadData, child: const Text('Erneut versuchen')),
          ],
        ),
      );
    }

    if (_listing == null) {
      return const Center(child: Text('Angebot nicht gefunden'));
    }

    return CustomScrollView(
      slivers: [
        // App Bar mit Bildergalerie
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildImageGallery(),
          ),
        ),

        // Inhalt
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titel und Preis
                _buildTitleSection(),
                const SizedBox(height: 16),

                // Schnellinfo
                _buildQuickInfo(),
                const SizedBox(height: 24),

                // Beschreibung
                _buildDescriptionSection(),
                const SizedBox(height: 24),

                // Details
                _buildDetailsSection(),
                const SizedBox(height: 24),

                // Zahlungsmethoden
                _buildPaymentSection(),
                const SizedBox(height: 24),

                // Versand
                if (_listing!.hasShipping) ...[
                  _buildShippingSection(),
                  const SizedBox(height: 24),
                ],

                // Kontakt Button
                _buildContactButton(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGallery() {
    if (_images.isEmpty) {
      return Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Stack(
      children: [
        PageView.builder(
          itemCount: _images.length,
          onPageChanged: (index) => setState(() => _currentImageIndex = index),
          itemBuilder: (context, index) {
            return FutureBuilder<Uint8List?>(
              future: client.listingImage.getImageData(_images[index].id!),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return GestureDetector(
                    onTap: () => _showFullScreenImage(snapshot.data!, index),
                    child: Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }
                return Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            );
          },
        ),

        // Bild-Indikator
        if (_images.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentImageIndex
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white.withAlpha(128),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  void _showFullScreenImage(Uint8List imageData, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenImageView(
          images: _images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    final unitLabel = _getQuantityUnitLabel(_listing!.quantityUnit);
    final priceText = _formatPrice(_listing!.pricePerUnit);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _listing!.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              priceText,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (unitLabel.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                '/ $unitLabel',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildQuickInfo() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // Kategorie
        if (_category != null)
          Chip(
            avatar: const Icon(Icons.category, size: 18),
            label: Text(_category!.name),
          ),

        // Menge
        Chip(
          avatar: const Icon(Icons.inventory, size: 18),
          label: Text(
            '${_listing!.quantity} ${_getQuantityUnitLabel(_listing!.quantityUnit)}',
          ),
        ),

        // Status
        if (!_listing!.isActive)
          Chip(
            avatar: const Icon(Icons.block, size: 18),
            label: const Text('Inaktiv'),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beschreibung',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          _listing!.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Menge', '${_listing!.quantity} ${_getQuantityUnitLabel(_listing!.quantityUnit)}'),
            _buildDetailRow('Preis pro Einheit', _formatPrice(_listing!.pricePerUnit)),
            _buildDetailRow('Erstellt am', _formatDate(_listing!.createdAt)),
            if (_listing!.expiresAt != null)
              _buildDetailRow('Läuft ab am', _formatDate(_listing!.expiresAt!)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  Widget _buildPaymentSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Akzeptierte Zahlungsmethoden',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (_listing!.acceptsPaypal)
                  Expanded(
                    child: _buildPaymentChip(Icons.payment, 'PayPal'),
                  ),
                if (_listing!.acceptsPaypal && _listing!.acceptsBitcoin)
                  const SizedBox(width: 12),
                if (_listing!.acceptsBitcoin)
                  Expanded(
                    child: _buildPaymentChip(Icons.currency_bitcoin, 'Bitcoin'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_shipping),
                const SizedBox(width: 8),
                Text(
                  'Versand',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_listing!.shippingMethod != null && _listing!.shippingMethod!.isNotEmpty)
              _buildDetailRow('Versandart', _listing!.shippingMethod!),
            if (_listing!.shippingCostCents != null)
              _buildDetailRow('Versandkosten', _formatPrice(_listing!.shippingCostCents!)),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nachrichten werden in Meilenstein 7 implementiert')),
          );
        },
        icon: const Icon(Icons.message),
        label: const Text('Verkäufer kontaktieren'),
      ),
    );
  }
}

/// Vollbild-Ansicht für Bilder.
class _FullScreenImageView extends StatefulWidget {
  final List<ListingImage> images;
  final int initialIndex;

  const _FullScreenImageView({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageView> createState() => _FullScreenImageViewState();
}

class _FullScreenImageViewState extends State<_FullScreenImageView> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text('${_currentIndex + 1} / ${widget.images.length}'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, index) {
          return FutureBuilder<Uint8List?>(
            future: client.listingImage.getImageData(widget.images[index].id!),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return InteractiveViewer(
                  child: Center(
                    child: Image.memory(
                      snapshot.data!,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            },
          );
        },
      ),
    );
  }
}
