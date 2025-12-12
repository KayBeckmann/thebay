import 'package:flutter/material.dart';

/// Search screen for finding listings.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String? _selectedCategory;
  String? _selectedPaymentMethod;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suchen'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar and filters
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search field
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Angebote suchen...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  onSubmitted: (_) => _performSearch(),
                ),
                const SizedBox(height: 12),

                // Filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: Text(_selectedCategory ?? 'Kategorie'),
                        selected: _selectedCategory != null,
                        onSelected: (_) => _showCategoryFilter(),
                        avatar: const Icon(Icons.category, size: 18),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: Text(_selectedPaymentMethod ?? 'Bezahlart'),
                        selected: _selectedPaymentMethod != null,
                        onSelected: (_) => _showPaymentMethodFilter(),
                        avatar: const Icon(Icons.payment, size: 18),
                      ),
                      const SizedBox(width: 8),
                      if (_selectedCategory != null ||
                          _selectedPaymentMethod != null)
                        ActionChip(
                          label: const Text('Filter löschen'),
                          onPressed: _clearFilters,
                          avatar: const Icon(Icons.clear, size: 18),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search results
          Expanded(
            child: _buildEmptyState(context),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Angebote durchsuchen',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Gib einen Suchbegriff ein oder wähle Filter aus, um Angebote zu finden.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() {
    // TODO: Implement search
  }

  void _showCategoryFilter() {
    // TODO: Show category selection dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kategorie wählen'),
        content: const Text('Kategorien werden in Meilenstein 4 implementiert.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodFilter() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Bezahlart wählen'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedPaymentMethod = 'PayPal');
              Navigator.pop(context);
            },
            child: const Text('PayPal'),
          ),
          SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedPaymentMethod = 'Bitcoin');
              Navigator.pop(context);
            },
            child: const Text('Bitcoin'),
          ),
        ],
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _selectedCategory = null;
      _selectedPaymentMethod = null;
    });
  }
}
