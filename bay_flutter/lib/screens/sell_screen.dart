import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'listings/create_listing_screen.dart';
import 'listings/edit_listing_screen.dart';
import 'listings/listing_card.dart';

/// Verkaufen-Screen für Angebote und Slots.
class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Meine Angebote
  List<Listing> _myListings = [];
  bool _isLoadingListings = true;

  // Meine Slots
  List<UserSlot> _mySlots = [];
  Map<String, int> _slotStats = {};
  bool _isLoadingSlots = true;

  // Slot-Varianten zum Kaufen
  List<SlotVariant> _slotVariants = [];
  bool _isLoadingVariants = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadMyListings(),
      _loadMySlots(),
      _loadSlotVariants(),
    ]);
  }

  Future<void> _loadMyListings() async {
    setState(() => _isLoadingListings = true);
    try {
      final listings = await client.listing.getMyListings();
      if (mounted) {
        setState(() {
          _myListings = listings;
          _isLoadingListings = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingListings = false);
      }
    }
  }

  Future<void> _loadMySlots() async {
    setState(() => _isLoadingSlots = true);
    try {
      final slots = await client.userSlot.getMySlots();
      final stats = await client.userSlot.getSlotStats();
      if (mounted) {
        setState(() {
          _mySlots = slots;
          _slotStats = stats;
          _isLoadingSlots = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingSlots = false);
      }
    }
  }

  Future<void> _loadSlotVariants() async {
    setState(() => _isLoadingVariants = true);
    try {
      final variants = await client.slotVariant.getActive();
      if (mounted) {
        setState(() {
          _slotVariants = variants;
          _isLoadingVariants = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingVariants = false);
      }
    }
  }

  int get _availableSlots => _slotStats['available'] ?? 0;

  Future<void> _createListing() async {
    if (_availableSlots <= 0) {
      _showNoSlotsDialog();
      return;
    }

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const CreateListingScreen()),
    );

    if (result == true) {
      _loadData();
    }
  }

  Future<void> _editListing(Listing listing) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => EditListingScreen(listing: listing)),
    );

    if (result == true) {
      _loadMyListings();
    }
  }

  Future<void> _deleteListing(Listing listing) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Angebot löschen'),
        content: Text('Möchtest du "${listing.title}" wirklich löschen? Der Slot wird freigegeben.'),
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

    if (confirmed == true) {
      try {
        await client.listing.delete(listing.id!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Angebot gelöscht')),
          );
          _loadData();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fehler: $e')),
          );
        }
      }
    }
  }

  void _showNoSlotsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.info_outline),
        title: const Text('Keine verfügbaren Slots'),
        content: const Text(
          'Um ein Angebot zu erstellen, benötigst du einen verfügbaren Slot. Kaufe zuerst einen Slot im "Meine Slots" Tab.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _tabController.animateTo(1);
            },
            child: const Text('Slots anzeigen'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verkaufen'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Meine Angebote (${_myListings.length})'),
            Tab(text: 'Meine Slots ($_availableSlots)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyListingsTab(),
          _buildMySlotsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createListing,
        icon: const Icon(Icons.add),
        label: const Text('Neues Angebot'),
      ),
    );
  }

  Widget _buildMyListingsTab() {
    if (_isLoadingListings) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_myListings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.storefront_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                'Keine Angebote',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Du hast noch keine Angebote erstellt.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (_availableSlots > 0)
                FilledButton.icon(
                  onPressed: _createListing,
                  icon: const Icon(Icons.add),
                  label: const Text('Erstes Angebot erstellen'),
                )
              else
                FilledButton.icon(
                  onPressed: () => _tabController.animateTo(1),
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Slots kaufen'),
                ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMyListings,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _myListings.length,
        itemBuilder: (context, index) {
          final listing = _myListings[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListingCard(
              listing: listing,
              showActions: true,
              onEdit: () => _editListing(listing),
              onDelete: () => _deleteListing(listing),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMySlotsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await _loadMySlots();
        await _loadSlotVariants();
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Slot-Statistiken
          _buildSlotStatsCard(),
          const SizedBox(height: 24),

          // Aktive Slots
          Text(
            'Aktive Slots',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          _buildActiveSlotsSection(),
          const SizedBox(height: 24),

          // Slots kaufen
          Text(
            'Slots kaufen',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          _buildBuySlotSection(),
        ],
      ),
    );
  }

  Widget _buildSlotStatsCard() {
    if (_isLoadingSlots) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildStatItem(
              context,
              'Verfügbar',
              '${_slotStats['available'] ?? 0}',
              Icons.check_circle,
              Colors.green,
            ),
            _buildStatItem(
              context,
              'Genutzt',
              '${_slotStats['used'] ?? 0}',
              Icons.inventory,
              Theme.of(context).colorScheme.primary,
            ),
            _buildStatItem(
              context,
              'Abgelaufen',
              '${_slotStats['expired'] ?? 0}',
              Icons.timer_off,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSlotsSection() {
    if (_isLoadingSlots) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final activeSlots = _mySlots.where((s) => s.isActive).toList();

    if (activeSlots.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Du hast keine aktiven Slots.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: activeSlots.map((slot) => _buildSlotCard(slot)).toList(),
    );
  }

  Widget _buildSlotCard(UserSlot slot) {
    final now = DateTime.now();
    final daysRemaining = slot.expiresAt.difference(now).inDays;
    final isExpiringSoon = daysRemaining <= 3 && daysRemaining >= 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: slot.isUsed
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.green.shade100,
          child: Icon(
            slot.isUsed ? Icons.inventory : Icons.check_circle,
            color: slot.isUsed
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Colors.green,
          ),
        ),
        title: Text(slot.isUsed ? 'Slot genutzt' : 'Slot verfügbar'),
        subtitle: Text(
          'Läuft ab: ${_formatDate(slot.expiresAt)}',
          style: TextStyle(
            color: isExpiringSoon ? Theme.of(context).colorScheme.error : null,
          ),
        ),
        trailing: isExpiringSoon
            ? Chip(
                label: Text('$daysRemaining Tage'),
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildBuySlotSection() {
    if (_isLoadingVariants) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_slotVariants.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                Icons.info_outline,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              Text(
                'Keine Slot-Varianten verfügbar',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                'Der Administrator muss zuerst Slot-Varianten konfigurieren.',
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

    return Column(
      children: _slotVariants.map((variant) => _buildSlotVariantCard(variant)).toList(),
    );
  }

  Widget _buildSlotVariantCard(SlotVariant variant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    variant.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (variant.description != null && variant.description!.isNotEmpty)
                    Text(
                      variant.description!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    '${variant.durationDays} Tage Laufzeit',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    children: [
                      if (variant.allowPaypal)
                        const Chip(
                          label: Text('PayPal'),
                          visualDensity: VisualDensity.compact,
                        ),
                      if (variant.allowBitcoin)
                        const Chip(
                          label: Text('Bitcoin'),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${(variant.priceUsdCents / 100).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => _buySlot(variant),
                  child: const Text('Kaufen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _buySlot(SlotVariant variant) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Slot-Kauf wird in Meilenstein 5d/5e implementiert'),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
