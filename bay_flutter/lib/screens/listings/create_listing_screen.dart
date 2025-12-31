import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

/// Screen zum Erstellen eines neuen Angebots.
class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _priceController = TextEditingController();
  final _shippingCostController = TextEditingController();
  final _shippingMethodController = TextEditingController();

  bool _isLoading = false;
  bool _isLoadingCategories = true;

  // Kategorien
  List<Category> _categories = [];
  List<Category> _mainCategories = [];
  List<Category> _subCategories = [];
  int? _selectedMainCategoryId;
  int? _selectedSubCategoryId;

  // Mengeneinheit
  QuantityUnit _quantityUnit = QuantityUnit.piece;

  // Zahlungsoptionen
  bool _acceptsPaypal = true;
  bool _acceptsBitcoin = false;

  // Versand
  bool _hasShipping = false;

  // Bilder
  final List<_ImageData> _images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadCategories();
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
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingCategories = false);
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.genericError.replaceAll('{error}', '')}: $e')),
        );
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

  Future<void> _pickImage() async {
    if (_images.length >= 3) {
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
        _images.add(_ImageData(
          name: image.name,
          bytes: bytes,
        ));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;

    // Validiere Kategorie
    final categoryId = _selectedSubCategoryId ?? _selectedMainCategoryId;
    if (categoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.categoryRequired)),
      );
      return;
    }

    // Validiere Zahlungsmethoden
    if (!_acceptsPaypal && !_acceptsBitcoin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.atLeastOnePaymentMethod)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Parse Preis (in Cents)
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

      // Erstelle Listing
      final listing = await client.listing.create(
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

      if (listing == null) {
        throw Exception(l10n.errorCreatingListing);
      }

      // Lade Bilder hoch
      for (final image in _images) {
        await client.listingImage.upload(
          listingId: listing.id!,
          originalFileName: image.name,
          imageData: image.bytes.buffer.asByteData(),
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.listingCreated)),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        final l10nError = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10nError.genericError.replaceAll('{error}', e.toString()))),
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
        title: Text(l10n.createListingTitle),
        actions: [
          if (!_isLoading)
            TextButton(
              onPressed: _submit,
              child: Text(l10n.create),
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
                  // Bilder
                  _buildImageSection(),
                  const SizedBox(height: 24),

                  // Titel
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: '${l10n.title} *',
                      hintText: l10n.titleHint,
                      prefixIcon: const Icon(Icons.title),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.titleRequired;
                      }
                      if (value.trim().length < 3) {
                        return 'Title must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Beschreibung
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: '${l10n.description} *',
                      hintText: l10n.descriptionHint,
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(Icons.description),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.descriptionRequired;
                      }
                      if (value.trim().length < 10) {
                        return 'Description must be at least 10 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Kategorie
                  _buildCategorySection(),
                  const SizedBox(height: 24),

                  // Menge & Preis
                  _buildPriceSection(),
                  const SizedBox(height: 24),

                  // Zahlungsmethoden
                  _buildPaymentSection(),
                  const SizedBox(height: 24),

                  // Versand
                  _buildShippingSection(),
                  const SizedBox(height: 32),

                  // Erstellen Button
                  FilledButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.check),
                    label: Text(l10n.createListingTitle),
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
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Vorhandene Bilder
              ..._images.asMap().entries.map((entry) {
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
                          onPressed: () => _removeImage(entry.key),
                          icon: const Icon(Icons.close, size: 16),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.all(4),
                            minimumSize: const Size(24, 24),
                          ),
                        ),
                      ),
                      if (entry.key == 0)
                        Positioned(
                          bottom: 4,
                          left: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Main',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),

              // Bild hinzufügen Button
              if (_images.length < 3)
                InkWell(
                  onTap: _pickImage,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignInside,
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
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.category} *',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        if (_isLoadingCategories)
          const Center(child: CircularProgressIndicator())
        else ...[
          DropdownButtonFormField<int>(
            value: _selectedMainCategoryId,
            decoration: InputDecoration(
              labelText: l10n.selectCategory,
              prefixIcon: const Icon(Icons.category),
            ),
            items: _mainCategories.map((category) {
              return DropdownMenuItem(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: _onMainCategoryChanged,
            validator: (value) {
              if (value == null) {
                return l10n.categoryRequired;
              }
              return null;
            },
          ),
          if (_subCategories.isNotEmpty) ...[
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _selectedSubCategoryId,
              decoration: InputDecoration(
                labelText: l10n.selectSubcategory,
                prefixIcon: const Icon(Icons.subdirectory_arrow_right),
              ),
              items: _subCategories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedSubCategoryId = value),
            ),
          ],
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menge
            Expanded(
              child: TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: '${l10n.quantity} *',
                  prefixIcon: const Icon(Icons.numbers),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.quantityRequired;
                  }
                  final parsed = double.tryParse(value.replaceAll(',', '.'));
                  if (parsed == null || parsed <= 0) {
                    return l10n.quantityInvalid;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            // Einheit
            Expanded(
              child: DropdownButtonFormField<QuantityUnit>(
                value: _quantityUnit,
                decoration: InputDecoration(
                  labelText: l10n.unit,
                ),
                items: [
                  DropdownMenuItem(value: QuantityUnit.piece, child: Text(l10n.unitPiece)),
                  DropdownMenuItem(value: QuantityUnit.kg, child: Text(l10n.unitKg)),
                  DropdownMenuItem(value: QuantityUnit.gram, child: Text(l10n.unitGram)),
                  DropdownMenuItem(value: QuantityUnit.meter, child: Text(l10n.unitMeter)),
                  DropdownMenuItem(value: QuantityUnit.liter, child: Text(l10n.unitLiter)),
                  DropdownMenuItem(value: QuantityUnit.none, child: const Text('None')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _quantityUnit = value);
                },
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
            hintText: l10n.priceHint,
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.priceRequired;
            }
            final parsed = double.tryParse(value.replaceAll(',', '.'));
            if (parsed == null || parsed < 0) {
              return l10n.priceInvalid;
            }
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              CheckboxListTile(
                value: _acceptsPaypal,
                onChanged: (value) => setState(() => _acceptsPaypal = value ?? false),
                title: Text(l10n.paypal),
                secondary: const Icon(Icons.payment),
              ),
              const Divider(height: 1),
              CheckboxListTile(
                value: _acceptsBitcoin,
                onChanged: (value) => setState(() => _acceptsBitcoin = value ?? false),
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                value: _hasShipping,
                onChanged: (value) => setState(() => _hasShipping = value),
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
                          hintText: 'e.g. DHL, UPS, Post...',
                          prefixIcon: const Icon(Icons.local_post_office),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _shippingCostController,
                        decoration: InputDecoration(
                          labelText: '${l10n.shippingCost} (USD)',
                          prefixIcon: const Icon(Icons.attach_money),
                          hintText: l10n.shippingCostHint,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                        ],
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

/// Hilfklasse für Bilddaten.
class _ImageData {
  final String name;
  final Uint8List bytes;

  _ImageData({required this.name, required this.bytes});
}
