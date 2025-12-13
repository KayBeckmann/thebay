import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Laden der Kategorien: $e')),
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
        const SnackBar(content: Text('Maximal 3 Bilder erlaubt')),
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

    // Validiere Kategorie
    final categoryId = _selectedSubCategoryId ?? _selectedMainCategoryId;
    if (categoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte wähle eine Kategorie aus')),
      );
      return;
    }

    // Validiere Zahlungsmethoden
    if (!_acceptsPaypal && !_acceptsBitcoin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mindestens eine Zahlungsmethode muss aktiviert sein')),
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
        throw Exception('Angebot konnte nicht erstellt werden');
      }

      // Lade Bilder hoch
      for (final image in _images) {
        await client.listingImage.upload(
          listingId: listing.id!,
          originalFileName: image.name,
          imageData: image.bytes,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Angebot erfolgreich erstellt!')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Angebot'),
        actions: [
          if (!_isLoading)
            TextButton(
              onPressed: _submit,
              child: const Text('Erstellen'),
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
                    decoration: const InputDecoration(
                      labelText: 'Titel *',
                      hintText: 'Was verkaufst du?',
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Titel ist erforderlich';
                      }
                      if (value.trim().length < 3) {
                        return 'Titel muss mindestens 3 Zeichen haben';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Beschreibung
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Beschreibung *',
                      hintText: 'Beschreibe dein Angebot...',
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Beschreibung ist erforderlich';
                      }
                      if (value.trim().length < 10) {
                        return 'Beschreibung muss mindestens 10 Zeichen haben';
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
                    label: const Text('Angebot erstellen'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bilder (max. 3)',
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
                              'Hauptbild',
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
                          'Bild hinzufügen',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategorie *',
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
            decoration: const InputDecoration(
              labelText: 'Hauptkategorie',
              prefixIcon: Icon(Icons.category),
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
                return 'Kategorie ist erforderlich';
              }
              return null;
            },
          ),
          if (_subCategories.isNotEmpty) ...[
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _selectedSubCategoryId,
              decoration: const InputDecoration(
                labelText: 'Unterkategorie (optional)',
                prefixIcon: Icon(Icons.subdirectory_arrow_right),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menge & Preis',
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
                decoration: const InputDecoration(
                  labelText: 'Menge *',
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Erforderlich';
                  }
                  final parsed = double.tryParse(value.replaceAll(',', '.'));
                  if (parsed == null || parsed <= 0) {
                    return 'Ungültige Menge';
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
                decoration: const InputDecoration(
                  labelText: 'Einheit',
                ),
                items: const [
                  DropdownMenuItem(value: QuantityUnit.piece, child: Text('Stück')),
                  DropdownMenuItem(value: QuantityUnit.kg, child: Text('Kilogramm')),
                  DropdownMenuItem(value: QuantityUnit.gram, child: Text('Gramm')),
                  DropdownMenuItem(value: QuantityUnit.meter, child: Text('Meter')),
                  DropdownMenuItem(value: QuantityUnit.liter, child: Text('Liter')),
                  DropdownMenuItem(value: QuantityUnit.none, child: Text('Ohne')),
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
          decoration: const InputDecoration(
            labelText: 'Preis pro Einheit (USD) *',
            prefixIcon: Icon(Icons.attach_money),
            hintText: '0.00',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Preis ist erforderlich';
            }
            final parsed = double.tryParse(value.replaceAll(',', '.'));
            if (parsed == null || parsed < 0) {
              return 'Ungültiger Preis';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Zahlungsmethoden *',
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
                title: const Text('PayPal'),
                secondary: const Icon(Icons.payment),
              ),
              const Divider(height: 1),
              CheckboxListTile(
                value: _acceptsBitcoin,
                onChanged: (value) => setState(() => _acceptsBitcoin = value ?? false),
                title: const Text('Bitcoin'),
                secondary: const Icon(Icons.currency_bitcoin),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShippingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Versand',
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
                title: const Text('Versand anbieten'),
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
                        decoration: const InputDecoration(
                          labelText: 'Versandart',
                          hintText: 'z.B. DHL, UPS, Post...',
                          prefixIcon: Icon(Icons.local_post_office),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _shippingCostController,
                        decoration: const InputDecoration(
                          labelText: 'Versandkosten (USD)',
                          prefixIcon: Icon(Icons.attach_money),
                          hintText: '0.00',
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
