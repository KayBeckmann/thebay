import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'favorites_screen.dart';
import 'listings/listing_card.dart';
import 'listings/listing_detail_screen.dart';

/// Search screen for finding listings.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  // Kategorien
  List<Category> _categories = [];
  Category? _selectedCategory;
  List<Category> _subcategories = [];
  Category? _selectedSubcategory;

  // Filter
  String? _selectedPaymentMethod;

  // Ergebnisse
  List<Listing> _results = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  int _totalCount = 0;
  bool _hasMore = false;
  int _currentPage = 0;
  final int _pageSize = 25;

  // Favoriten-Status
  Map<int, bool> _favoriteStatus = {};

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await client.category.getRootCategories();
      if (mounted) {
        setState(() => _categories = categories);
      }
    } catch (e) {
      // Kategorien konnten nicht geladen werden
    }
  }

  Future<void> _loadSubcategories(int parentId) async {
    try {
      final subcategories = await client.category.getSubcategories(parentId);
      if (mounted) {
        setState(() => _subcategories = subcategories);
      }
    } catch (e) {
      // Subkategorien konnten nicht geladen werden
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _currentPage = 0;
      _results = [];
    });

    try {
      final result = await client.search.search(
        query: _searchController.text.isEmpty ? null : _searchController.text,
        categoryId: _selectedCategory?.id,
        subcategoryId: _selectedSubcategory?.id,
        acceptsPaypal: _selectedPaymentMethod == 'PayPal' ? true : null,
        acceptsBitcoin: _selectedPaymentMethod == 'Bitcoin' ? true : null,
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (mounted) {
        setState(() {
          _results = result.listings;
          _totalCount = result.totalCount;
          _hasMore = result.hasMore;
          _isLoading = false;
        });

        // Lade Favoriten-Status
        if (result.listings.isNotEmpty) {
          _loadFavoriteStatus(result.listings.map((l) => l.id!).toList());
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler bei der Suche: $e')),
        );
      }
    }
  }

  Future<void> _loadMore() async {
    if (!_hasMore || _isLoading) return;

    setState(() => _isLoading = true);
    _currentPage++;

    try {
      final result = await client.search.search(
        query: _searchController.text.isEmpty ? null : _searchController.text,
        categoryId: _selectedCategory?.id,
        subcategoryId: _selectedSubcategory?.id,
        acceptsPaypal: _selectedPaymentMethod == 'PayPal' ? true : null,
        acceptsBitcoin: _selectedPaymentMethod == 'Bitcoin' ? true : null,
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (mounted) {
        setState(() {
          _results.addAll(result.listings);
          _hasMore = result.hasMore;
          _isLoading = false;
        });

        // Lade Favoriten-Status für neue Ergebnisse
        if (result.listings.isNotEmpty) {
          _loadFavoriteStatus(result.listings.map((l) => l.id!).toList());
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _currentPage--;
        });
      }
    }
  }

  Future<void> _loadFavoriteStatus(List<int> listingIds) async {
    try {
      final status = await client.favorite.checkMultiple(listingIds);
      if (mounted) {
        setState(() {
          _favoriteStatus.addAll(status);
        });
      }
    } catch (e) {
      // Favoriten-Status konnte nicht geladen werden
    }
  }

  Future<void> _toggleFavorite(int listingId) async {
    final isFavorite = _favoriteStatus[listingId] ?? false;

    // Optimistisches UI-Update
    setState(() {
      _favoriteStatus[listingId] = !isFavorite;
    });

    try {
      if (isFavorite) {
        await client.favorite.remove(listingId);
      } else {
        await client.favorite.add(listingId);
      }
    } catch (e) {
      // Rollback bei Fehler
      if (mounted) {
        setState(() {
          _favoriteStatus[listingId] = isFavorite;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    }
  }

  void _openListing(Listing listing) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListingDetailScreen(listingId: listing.id!),
      ),
    ).then((_) {
      // Aktualisiere Favoriten-Status nach Rückkehr
      if (listing.id != null) {
        _loadFavoriteStatus([listing.id!]);
      }
    });
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
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => _showFavorites(context),
            tooltip: 'Favoriten',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar and filters
          _buildSearchHeader(context),

          // Search results
          Expanded(
            child: _buildResultsArea(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
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
                // Kategorie Filter
                FilterChip(
                  label: Text(_selectedCategory?.name ?? 'Kategorie'),
                  selected: _selectedCategory != null,
                  onSelected: (_) => _showCategoryFilter(),
                  avatar: const Icon(Icons.category, size: 18),
                ),
                const SizedBox(width: 8),

                // Subkategorie Filter (nur wenn Kategorie gewählt)
                if (_selectedCategory != null && _subcategories.isNotEmpty) ...[
                  FilterChip(
                    label: Text(_selectedSubcategory?.name ?? 'Subkategorie'),
                    selected: _selectedSubcategory != null,
                    onSelected: (_) => _showSubcategoryFilter(),
                    avatar: const Icon(Icons.subdirectory_arrow_right, size: 18),
                  ),
                  const SizedBox(width: 8),
                ],

                // Zahlungsmethode Filter
                FilterChip(
                  label: Text(_selectedPaymentMethod ?? 'Bezahlart'),
                  selected: _selectedPaymentMethod != null,
                  onSelected: (_) => _showPaymentMethodFilter(),
                  avatar: const Icon(Icons.payment, size: 18),
                ),
                const SizedBox(width: 8),

                // Filter löschen
                if (_selectedCategory != null ||
                    _selectedSubcategory != null ||
                    _selectedPaymentMethod != null)
                  ActionChip(
                    label: const Text('Filter löschen'),
                    onPressed: _clearFilters,
                    avatar: const Icon(Icons.clear, size: 18),
                  ),
              ],
            ),
          ),

          // Suchen-Button
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _performSearch,
              icon: const Icon(Icons.search),
              label: const Text('Suchen'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsArea(BuildContext context) {
    if (!_hasSearched) {
      return _buildEmptyState(context);
    }

    if (_isLoading && _results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_results.isEmpty) {
      return _buildNoResultsState(context);
    }

    return Column(
      children: [
        // Ergebnis-Info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                '$_totalCount Ergebnis${_totalCount == 1 ? '' : 'se'}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const Spacer(),
            ],
          ),
        ),

        // Ergebnisliste
        Expanded(
          child: RefreshIndicator(
            onRefresh: _performSearch,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: _results.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _results.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final listing = _results[index];
                final isFavorite = _favoriteStatus[listing.id] ?? false;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _openListing(listing),
                        child: ListingCard(listing: listing),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? Theme.of(context).colorScheme.error
                                : null,
                          ),
                          onPressed: () => _toggleFavorite(listing.id!),
                          style: IconButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
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

  Widget _buildNoResultsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Keine Ergebnisse',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Versuche andere Suchbegriffe oder passe die Filter an.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: _clearFilters,
              child: const Text('Filter zurücksetzen'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('Keine Kategorie'),
              onTap: () {
                setState(() {
                  _selectedCategory = null;
                  _selectedSubcategory = null;
                  _subcategories = [];
                });
                Navigator.pop(context);
              },
            ),
            const Divider(),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return ListTile(
                    leading: const Icon(Icons.category),
                    title: Text(category.name),
                    selected: _selectedCategory?.id == category.id,
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                        _selectedSubcategory = null;
                      });
                      _loadSubcategories(category.id!);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSubcategoryFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('Alle Subkategorien'),
              onTap: () {
                setState(() => _selectedSubcategory = null);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _subcategories.length,
                itemBuilder: (context, index) {
                  final subcategory = _subcategories[index];
                  return ListTile(
                    leading: const Icon(Icons.subdirectory_arrow_right),
                    title: Text(subcategory.name),
                    selected: _selectedSubcategory?.id == subcategory.id,
                    onTap: () {
                      setState(() => _selectedSubcategory = subcategory);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentMethodFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('Alle Bezahlarten'),
              onTap: () {
                setState(() => _selectedPaymentMethod = null);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('PayPal'),
              selected: _selectedPaymentMethod == 'PayPal',
              onTap: () {
                setState(() => _selectedPaymentMethod = 'PayPal');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.currency_bitcoin),
              title: const Text('Bitcoin'),
              selected: _selectedPaymentMethod == 'Bitcoin',
              onTap: () {
                setState(() => _selectedPaymentMethod = 'Bitcoin');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _selectedCategory = null;
      _selectedSubcategory = null;
      _selectedPaymentMethod = null;
      _subcategories = [];
    });
  }

  void _showFavorites(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesScreen()),
    );
  }
}
