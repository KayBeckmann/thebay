import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

/// Admin screen for managing slot variants.
class SlotVariantsScreen extends StatefulWidget {
  const SlotVariantsScreen({super.key});

  @override
  State<SlotVariantsScreen> createState() => _SlotVariantsScreenState();
}

class _SlotVariantsScreenState extends State<SlotVariantsScreen> {
  List<SlotVariant> _variants = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadVariants();
  }

  Future<void> _loadVariants() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final variants = await client.slotVariant.getAll();
      if (mounted) {
        setState(() {
          _variants = variants;
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
    final dollars = cents / 100;
    return '\$${dollars.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slot-Varianten verwalten'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showVariantDialog(null),
        child: const Icon(Icons.add),
      ),
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
            Text('Fehler: $_error'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadVariants,
              child: const Text('Erneut versuchen'),
            ),
          ],
        ),
      );
    }

    if (_variants.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.confirmation_number_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              'Keine Slot-Varianten',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Erstelle die erste Slot-Variante mit dem + Button.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadVariants,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _variants.length,
        itemBuilder: (context, index) {
          final variant = _variants[index];
          return _buildVariantCard(variant);
        },
      ),
    );
  }

  Widget _buildVariantCard(SlotVariant variant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  variant.isActive
                      ? Icons.confirmation_number
                      : Icons.confirmation_number_outlined,
                  color: variant.isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        variant.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: variant.isActive
                                      ? null
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                ),
                      ),
                      if (variant.description != null)
                        Text(
                          variant.description!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                    ],
                  ),
                ),
                if (!variant.isActive)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Inaktiv',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip(
                  context,
                  Icons.attach_money,
                  _formatPrice(variant.priceUsdCents),
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  context,
                  Icons.schedule,
                  '${variant.durationDays} Tage',
                ),
                const SizedBox(width: 8),
                if (variant.allowPaypal)
                  _buildInfoChip(context, Icons.paypal, 'PayPal'),
                if (variant.allowPaypal && variant.allowBitcoin)
                  const SizedBox(width: 8),
                if (variant.allowBitcoin)
                  _buildInfoChip(context, Icons.currency_bitcoin, 'Bitcoin'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => _showVariantDialog(variant),
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Bearbeiten'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => _confirmDelete(variant),
                  icon: Icon(Icons.delete, size: 18, color: Theme.of(context).colorScheme.error),
                  label: Text('Löschen', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.onSecondaryContainer),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> _showVariantDialog(SlotVariant? variant) async {
    final isEditing = variant != null;
    final nameController = TextEditingController(text: variant?.name ?? '');
    final descriptionController =
        TextEditingController(text: variant?.description ?? '');
    final priceController = TextEditingController(
        text: variant != null ? (variant.priceUsdCents / 100).toString() : '');
    final durationController =
        TextEditingController(text: (variant?.durationDays ?? 30).toString());
    final sortOrderController =
        TextEditingController(text: (variant?.sortOrder ?? 0).toString());
    bool allowPaypal = variant?.allowPaypal ?? true;
    bool allowBitcoin = variant?.allowBitcoin ?? true;
    bool isActive = variant?.isActive ?? true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? 'Slot-Variante bearbeiten' : 'Neue Slot-Variante'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'z.B. Standard, Premium',
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Beschreibung (optional)',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: 'Preis (USD)',
                          prefixText: '\$ ',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: durationController,
                        decoration: const InputDecoration(
                          labelText: 'Laufzeit (Tage)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: sortOrderController,
                  decoration: const InputDecoration(
                    labelText: 'Sortierung',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                const Text('Zahlungsmethoden', style: TextStyle(fontWeight: FontWeight.bold)),
                CheckboxListTile(
                  title: const Text('PayPal'),
                  value: allowPaypal,
                  onChanged: (value) => setDialogState(() => allowPaypal = value ?? true),
                ),
                CheckboxListTile(
                  title: const Text('Bitcoin'),
                  value: allowBitcoin,
                  onChanged: (value) => setDialogState(() => allowBitcoin = value ?? true),
                ),
                SwitchListTile(
                  title: const Text('Aktiv'),
                  subtitle: const Text('Variante kann gekauft werden'),
                  value: isActive,
                  onChanged: (value) => setDialogState(() => isActive = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(isEditing ? 'Speichern' : 'Erstellen'),
            ),
          ],
        ),
      ),
    );

    if (result == true && mounted) {
      final name = nameController.text.trim();
      final description = descriptionController.text.trim();
      final price = double.tryParse(priceController.text) ?? 0;
      final priceInCents = (price * 100).round();
      final duration = int.tryParse(durationController.text) ?? 30;
      final sortOrder = int.tryParse(sortOrderController.text) ?? 0;

      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name darf nicht leer sein')),
        );
        return;
      }

      if (!allowPaypal && !allowBitcoin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mindestens eine Zahlungsmethode muss aktiviert sein')),
        );
        return;
      }

      try {
        if (isEditing) {
          await client.slotVariant.update(
            id: variant.id!,
            name: name,
            description: description.isEmpty ? null : description,
            priceUsdCents: priceInCents,
            durationDays: duration,
            allowPaypal: allowPaypal,
            allowBitcoin: allowBitcoin,
            isActive: isActive,
            isFree: variant.isFree, // Preserve existing value
            sortOrder: sortOrder,
          );
        } else {
          await client.slotVariant.create(
            name: name,
            description: description.isEmpty ? null : description,
            priceUsdCents: priceInCents,
            durationDays: duration,
            allowPaypal: allowPaypal,
            allowBitcoin: allowBitcoin,
            sortOrder: sortOrder,
            isFree: false, // Normal paid slot
          );
        }
        _loadVariants();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fehler: $e')),
          );
        }
      }
    }
  }

  Future<void> _confirmDelete(SlotVariant variant) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Slot-Variante löschen'),
        content: Text('Möchtest du "${variant.name}" wirklich löschen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await client.slotVariant.delete(variant.id!);
        _loadVariants();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fehler beim Löschen: $e')),
          );
        }
      }
    }
  }
}
