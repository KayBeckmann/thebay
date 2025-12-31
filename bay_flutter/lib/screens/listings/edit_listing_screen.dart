import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

/// Screen zum Bearbeiten eines bestehenden Angebots.
class EditListingScreen extends StatefulWidget {
  final Listing listing;

  const EditListingScreen({super.key, required this.listing});

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _quantityController;
  late final TextEditingController _priceController;
  late final TextEditingController _shippingCostController;
  late final TextEditingController _shippingMethodController;

  bool _isLoading = false;
  bool _isLoadingCategories = true;
  bool _isLoadingImages = true;

  // Kategorien
  List<Category> _categories = [];
  List<Category> _mainCategories = [];
  List<Category> _subCategories = [];
  int? _selectedMainCategoryId;
  int? _selectedSubCategoryId;

  // Mengeneinheit
  late QuantityUnit _quantityUnit;

  // Zahlungsoptionen
  late bool _acceptsPaypal;
  late bool _acceptsBitcoin;

  // Versand
  late bool _hasShipping;

  // Bilder
  List<ListingImage> _existingImages = [];
  final List<_NewImageData> _newImages = [];
  final List<int> _imagesToDelete = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeFromListing();
    _loadCategories();
    _loadExistingImages();
  }

  void _initializeFromListing() {
    _titleController = TextEditingController(text: widget.listing.title);
    _descriptionController = TextEditingController(text: widget.listing.description);
    _quantityController = TextEditingController(text: widget.listing.quantity.toString());
    _priceController = TextEditingController(
      text: (widget.listing.pricePerUnit / 100).toStringAsFixed(2),
    );
    _shippingMethodController = TextEditingController(
      text: widget.listing.shippingMethod ?? '',
    );
    _shippingCostController = TextEditingController(
      text: widget.listing.shippingCostCents != null
          ? (widget.listing.shippingCostCents! / 100).toStringAsFixed(2)
          : '',
    );

    _quantityUnit = widget.listing.quantityUnit;
    _acceptsPaypal = widget.listing.acceptsPaypal;
    _acceptsBitcoin = widget.listing.acceptsBitcoin;
    _hasShipping = widget.listing.hasShipping;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _shippingCostController.dispose();
    _shippingMethodController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await client.category.getAll();
      if (mounted) {
        setState(() {
          _categories = categories;
          _mainCategories = categories.where((c) => c.parentId == null).toList();
          _isLoadingCategories = false;
        });

        // Finde die aktuelle Kategorie
        final currentCategory = categories.firstWhere(
          (c) => c.id == widget.listing.categoryId,
          orElse: () => categories.first,
        );

        if (currentCategory.parentId != null) {
          // Es ist eine Subkategorie
          _selectedMainCategoryId = currentCategory.parentId;
          _selectedSubCategoryId = currentCategory.id;
          _subCategories = categories.where((c) => c.parentId == currentCategory.parentId).toList();
        } else {
          // Es ist eine Hauptkategorie
          _selectedMainCategoryId = currentCategory.id;
          _subCategories = categories.where((c) => c.parentId == currentCategory.id).toList();
        }
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingCategories = false);
      }
    }
  }

  Future<void> _loadExistingImages() async {
    try {
      final images = await client.listingImage.getByListing(widget.listing.id!);
      if (mounted) {
        setState(() {
          _existingImages = images;
          _isLoadingImages = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingImages = false);
      }
    }
  }

  void _onMainCategoryChanged(int? categoryId) {
    setState(() {
      _selectedMainCategoryId = categoryId;
      _selectedSubCategoryId = null;
      if (categoryId != null) {
        _subCategories = _categories.where((c) => c.parentId == categoryId).toList();
      } else {
        _subCategories = [];
      }
    });
  }

  int get _totalImageCount =>
      _existingImages.where((i) => !_imagesToDelete.contains(i.id)).length + _newImages.length;

  Future<void> _pickImage() async {
    if (_totalImageCount >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Maximum 3 images allowed')),
      );
      return;
    }

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _newImages.add(_NewImageData(name: image.name, bytes: bytes));
      });
    }
  }

  void _markImageForDeletion(int imageId) {
    setState(() {
      _imagesToDelete.add(imageId);
    });
  }

  void _removeNewImage(int index) {
    setState(() {
      _newImages.removeAt(index);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;

    final categoryId = _selectedSubCategoryId ?? _selectedMainCategoryId;
    if (categoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.categoryRequired)),
      );
      return;
    }

    if (!_acceptsPaypal && !_acceptsBitcoin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.atLeastOnePaymentMethod)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Parse Preis
      final priceText = _priceController.text.replaceAll(',', '.');
      final price = double.parse(priceText);
      final priceCents = (price * 100).round();

      // Parse Versandkosten
      int? shippingCostCents;
      if (_hasShipping && _shippingCostController.text.isNotEmpty) {
        final shippingText = _shippingCostController.text.replaceAll(',', '.');
        final shippingCost = double.parse(shippingText);
        shippingCostCents = (shippingCost * 100).round();
      }

      // Aktualisiere Listing
      await client.listing.update(
        id: widget.listing.id!,
        categoryId: categoryId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        quantity: double.parse(_quantityController.text.replaceAll(',', '.')),
        quantityUnit: _quantityUnit,
        pricePerUnit: priceCents,
        acceptsPaypal: _acceptsPaypal,
        acceptsBitcoin: _acceptsBitcoin,
        hasShipping: _hasShipping,
        shippingMethod: _hasShipping ? _shippingMethodController.text.trim() : null,
        shippingCostCents: shippingCostCents,
      );

      // Lösche markierte Bilder
      for (final imageId in _imagesToDelete) {
        await client.listingImage.delete(imageId);
      }

      // Lade neue Bilder hoch
      for (final image in _newImages) {
        await client.listingImage.upload(
          listingId: widget.listing.id!,
          originalFileName: image.name,
          imageData: image.bytes.buffer.asByteData(),
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.listingUpdated)),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        final l10nError = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10nError.genericError(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editListingTitle),
        actions: [
          if (!_isLoading)
            TextButton(
              onPressed: _submit,
              child: Text(l10n.save),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildImageSection(),
                  const SizedBox(height: 24),
                  _buildTitleField(),
                  const SizedBox(height: 16),
                  _buildDescriptionField(),
                  const SizedBox(height: 24),
                  _buildCategorySection(),
                  const SizedBox(height: 24),
                  _buildPriceSection(),
                  const SizedBox(height: 24),
                  _buildPaymentSection(),
                  const SizedBox(height: 24),
                  _buildShippingSection(),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.save),
                    label: Text(l10n.save),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildImageSection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.images} (max. 3)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        if (_isLoadingImages)
          const Center(child: CircularProgressIndicator())
        else
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // Bestehende Bilder
                ..._existingImages
                    .where((i) => !_imagesToDelete.contains(i.id))
                    .map((image) => _buildExistingImageTile(image)),

                // Neue Bilder
                ..._newImages.asMap().entries.map((entry) => _buildNewImageTile(entry)),

                // Hinzufügen Button
                if (_totalImageCount < 3) _buildAddImageButton(),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildExistingImageTile(ListingImage image) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          FutureBuilder<ByteData?>(
            future: client.listingImage.getImageData(image.id!),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    snapshot.data!.buffer.asUint8List(),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                );
              }
              return Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton.filled(
              onPressed: () => _markImageForDeletion(image.id!),
              icon: const Icon(Icons.close, size: 16),
              style: IconButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(4),
                minimumSize: const Size(24, 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewImageTile(MapEntry<int, _NewImageData> entry) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.memory(
              entry.value.bytes,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton.filled(
              onPressed: () => _removeNewImage(entry.key),
              icon: const Icon(Icons.close, size: 16),
              style: IconButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(4),
                minimumSize: const Size(24, 24),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'New',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddImageButton() {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate,
              size: 32,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context)!.addImages,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: '${l10n.title} *',
        prefixIcon: const Icon(Icons.title),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return l10n.titleRequired;
        if (value.trim().length < 3) return 'At least 3 characters';
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: '${l10n.description} *',
        alignLabelWithHint: true,
        prefixIcon: const Icon(Icons.description),
      ),
      maxLines: 5,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return l10n.descriptionRequired;
        if (value.trim().length < 10) return 'At least 10 characters';
        return null;
      },
    );
  }

  Widget _buildCategorySection() {
    if (_isLoadingCategories) {
      return const Center(child: CircularProgressIndicator());
    }

    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.category} *',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: _selectedMainCategoryId,
          decoration: InputDecoration(
            labelText: l10n.selectCategory,
            prefixIcon: const Icon(Icons.category),
          ),
          items: _mainCategories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
          onChanged: _onMainCategoryChanged,
        ),
        if (_subCategories.isNotEmpty) ...[
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            value: _selectedSubCategoryId,
            decoration: InputDecoration(
              labelText: l10n.selectSubcategory,
              prefixIcon: const Icon(Icons.subdirectory_arrow_right),
            ),
            items: _subCategories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
            onChanged: (v) => setState(() => _selectedSubCategoryId = v),
          ),
        ],
      ],
    );
  }

  Widget _buildPriceSection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.quantity} & ${l10n.price}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: '${l10n.quantity} *', prefixIcon: const Icon(Icons.numbers)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))],
                validator: (v) {
                  if (v == null || v.isEmpty) return l10n.quantityRequired;
                  if (double.tryParse(v.replaceAll(',', '.')) == null) return l10n.quantityInvalid;
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<QuantityUnit>(
                value: _quantityUnit,
                decoration: InputDecoration(labelText: l10n.unit),
                items: [
                  DropdownMenuItem(value: QuantityUnit.piece, child: Text(l10n.unitPiece)),
                  DropdownMenuItem(value: QuantityUnit.kg, child: Text(l10n.unitKg)),
                  DropdownMenuItem(value: QuantityUnit.gram, child: Text(l10n.unitGram)),
                  DropdownMenuItem(value: QuantityUnit.meter, child: Text(l10n.unitMeter)),
                  DropdownMenuItem(value: QuantityUnit.liter, child: Text(l10n.unitLiter)),
                  DropdownMenuItem(value: QuantityUnit.none, child: const Text('None')),
                ],
                onChanged: (v) => setState(() => _quantityUnit = v!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _priceController,
          decoration: InputDecoration(
            labelText: '${l10n.price} (USD) *',
            prefixIcon: const Icon(Icons.attach_money),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))],
          validator: (v) {
            if (v == null || v.isEmpty) return l10n.priceRequired;
            if (double.tryParse(v.replaceAll(',', '.')) == null) return l10n.priceInvalid;
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.selectPaymentMethods} *',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              CheckboxListTile(
                value: _acceptsPaypal,
                onChanged: (v) => setState(() => _acceptsPaypal = v ?? false),
                title: Text(l10n.paypal),
                secondary: const Icon(Icons.payment),
              ),
              const Divider(height: 1),
              CheckboxListTile(
                value: _acceptsBitcoin,
                onChanged: (v) => setState(() => _acceptsBitcoin = v ?? false),
                title: Text(l10n.bitcoin),
                secondary: const Icon(Icons.currency_bitcoin),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShippingSection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.shippingOptions,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                value: _hasShipping,
                onChanged: (v) => setState(() => _hasShipping = v),
                title: Text(l10n.shippingAvailable),
                secondary: const Icon(Icons.local_shipping),
              ),
              if (_hasShipping) ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _shippingMethodController,
                        decoration: InputDecoration(
                          labelText: l10n.shippingMethod,
                          prefixIcon: const Icon(Icons.local_post_office),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _shippingCostController,
                        decoration: InputDecoration(
                          labelText: '${l10n.shippingCost} (USD)',
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _NewImageData {
  final String name;
  final Uint8List bytes;
  _NewImageData({required this.name, required this.bytes});
}
