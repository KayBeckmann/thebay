import 'dart:typed_data';

import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart' show client, authService;
import '../messages_screen.dart' show showComposeMessageDialog;
import '../user_profile_screen.dart';
import '../transactions/start_transaction_dialog.dart';

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
  String? _sellerUsername;
  bool _isLoading = true;
  String? _error;
  int _currentImageIndex = 0;
  final PageController _imagePageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
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

      // Lade Verkäufer-Namen
      final sellerUsername = await client.userProfile.getUsername(listing.userId);

      if (mounted) {
        setState(() {
          _listing = listing;
          _images = images;
          _category = category;
          _sellerUsername = sellerUsername;
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

                // Verkäufer
                _buildSellerSection(),
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
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _imagePageController,
          itemCount: _images.length,
          onPageChanged: (index) => setState(() => _currentImageIndex = index),
          itemBuilder: (context, index) {
            return _ImagePageItem(
              imageId: _images[index].id!,
              onTap: (imageBytes) => _showFullScreenImage(imageBytes, index),
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
                return GestureDetector(
                  onTap: () {
                    _imagePageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentImageIndex
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white.withAlpha(128),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                  ),
                );
              }),
            ),
          ),

        // Pfeil-Navigation für Desktop
        if (_images.length > 1) ...[
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                onPressed: _currentImageIndex > 0
                    ? () => _imagePageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        )
                    : null,
                icon: const Icon(Icons.chevron_left, size: 32),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black54,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.black26,
                ),
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                onPressed: _currentImageIndex < _images.length - 1
                    ? () => _imagePageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        )
                    : null,
                icon: const Icon(Icons.chevron_right, size: 32),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black54,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.black26,
                ),
              ),
            ),
          ),
        ],
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

  Widget _buildSellerSection() {
    final isOwnListing = _listing!.userId == authService.currentUser?.userId;

    return Card(
      child: InkWell(
        onTap: () => _openSellerProfile(),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  (_sellerUsername ?? '?').substring(0, 1).toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(width: 12),

              // Verkäuferinfo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _sellerUsername ?? 'Unbekannt',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (isOwnListing) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Du',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Verkäufer',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),

              // Pfeil
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSellerProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(userId: _listing!.userId),
      ),
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
    // Prüfe ob es das eigene Angebot ist
    final currentUserId = authService.currentUser?.userId;
    final isOwnListing = _listing!.userId == currentUserId;

    if (isOwnListing) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Buy Button
        FilledButton.icon(
          onPressed: () {
            showStartTransactionDialog(context, listing: _listing!);
          },
          icon: const Icon(Icons.shopping_cart),
          label: const Text('Buy Now'),
        ),
        const SizedBox(height: 12),
        // Contact Button
        OutlinedButton.icon(
          onPressed: () {
            showComposeMessageDialog(
              context,
              recipientId: _listing!.userId,
              listingId: _listing!.id,
            );
          },
          icon: const Icon(Icons.message),
          label: const Text('Contact Seller'),
        ),
      ],
    );
  }
}

/// Widget für einzelne Bilder in der Galerie mit Caching.
class _ImagePageItem extends StatefulWidget {
  final int imageId;
  final void Function(Uint8List imageBytes) onTap;

  const _ImagePageItem({
    required this.imageId,
    required this.onTap,
  });

  @override
  State<_ImagePageItem> createState() => _ImagePageItemState();
}

class _ImagePageItemState extends State<_ImagePageItem> {
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
      final data = await client.listingImage.getImageData(widget.imageId);
      if (mounted && data != null) {
        setState(() {
          _imageData = data.buffer.asUint8List();
          _isLoading = false;
        });
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
            Icons.broken_image,
            size: 48,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => widget.onTap(_imageData!),
      child: Image.memory(
        _imageData!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
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
          return FutureBuilder<ByteData?>(
            future: client.listingImage.getImageData(widget.images[index].id!),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return InteractiveViewer(
                  child: Center(
                    child: Image.memory(
                      snapshot.data!.buffer.asUint8List(),
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
