import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

  // Ausstehende Bestellungen
  List<SlotOrder> _pendingOrders = [];
  bool _isLoadingOrders = false;

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
      _loadPendingOrders(),
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

  Future<void> _loadPendingOrders() async {
    setState(() => _isLoadingOrders = true);
    try {
      final orders = await client.slotOrder.getPendingOrders();
      if (mounted) {
        setState(() {
          _pendingOrders = orders;
          _isLoadingOrders = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingOrders = false);
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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        itemCount: _myListings.length,
        itemBuilder: (context, index) {
          final listing = _myListings[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListingListTile(
              listing: listing,
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
        await _loadPendingOrders();
      },
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          // Slot-Statistiken
          _buildSlotStatsCard(),
          const SizedBox(height: 24),

          // Ausstehende Bestellungen
          if (_pendingOrders.isNotEmpty) ...[
            Text(
              'Ausstehende Bestellungen',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            _buildPendingOrdersSection(),
            const SizedBox(height: 24),
          ],

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

  Widget _buildPendingOrdersSection() {
    if (_isLoadingOrders) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Column(
      children: _pendingOrders.map((order) => _buildPendingOrderCard(order)).toList(),
    );
  }

  Widget _buildPendingOrderCard(SlotOrder order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.5),
      child: InkWell(
        onTap: () => _viewPaymentDetails(order),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    order.paymentMethod == PaymentMethod.paypal
                        ? Icons.payment
                        : Icons.currency_bitcoin,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bestellung #${order.id}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        order.paymentMethod == PaymentMethod.paypal
                            ? 'PayPal - Warte auf Zahlung'
                            : 'Bitcoin - Warte auf Bestätigung',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '\$${(order.amountCents / 100).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  'Erstellt: ${_formatDate(order.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _cancelOrder(order),
                  child: const Text('Stornieren'),
                ),
                const SizedBox(width: 8),
                if (order.paymentMethod == PaymentMethod.bitcoin)
                  OutlinedButton.icon(
                    onPressed: () => _enterBitcoinTxId(order),
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('TX-ID eingeben'),
                  ),
                if (order.paymentMethod == PaymentMethod.bitcoin)
                  const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () => _viewPaymentDetails(order),
                  icon: const Icon(Icons.info_outline, size: 16),
                  label: const Text('Zahlen'),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cancelOrder(SlotOrder order) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bestellung stornieren'),
        content: Text(
          'Möchtest du die Bestellung #${order.id} wirklich stornieren?',
        ),
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
            child: const Text('Stornieren'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await client.slotOrder.cancel(order.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bestellung storniert')),
        );
        _loadPendingOrders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    }
  }

  Future<void> _enterBitcoinTxId(SlotOrder order) async {
    final controller = TextEditingController(text: order.transactionId ?? '');

    final txId = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.currency_bitcoin),
        title: const Text('Bitcoin-Transaktions-ID'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gib die Bitcoin-Transaktions-ID (TX-Hash) ein, '
              'nachdem du die Zahlung gesendet hast:',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'TX-ID / TX-Hash',
                hintText: 'z.B. abc123def456...',
                prefixIcon: Icon(Icons.tag),
              ),
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Speichern'),
          ),
        ],
      ),
    );

    if (txId == null || txId.isEmpty) return;

    try {
      await client.payment.setBitcoinTransactionId(
        orderId: order.id!,
        transactionId: txId,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaktions-ID gespeichert')),
        );
        _loadPendingOrders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    }
  }

  Future<void> _viewPaymentDetails(SlotOrder order) async {
    try {
      final info = await client.payment.getPaymentInfo(order.id!);

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(
            order.paymentMethod == PaymentMethod.paypal
                ? Icons.payment
                : Icons.currency_bitcoin,
          ),
          title: Text(
            order.paymentMethod == PaymentMethod.paypal
                ? 'PayPal-Zahlung'
                : 'Bitcoin-Zahlung',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (order.paymentMethod == PaymentMethod.paypal) ...[
                _buildPaymentInfoItem('Empfänger', info['email'] ?? '-'),
                _buildPaymentInfoItem('Betrag', '\$${info['amount']}'),
                _buildPaymentInfoItem('Verwendungszweck', 'Order-${order.id}'),
                const SizedBox(height: 16),
                const Text(
                  'Bitte sende den Betrag an die angegebene PayPal-Adresse '
                  'und gib den Verwendungszweck an.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ] else ...[
                _buildPaymentInfoItem('Adresse', info['address'] ?? '-'),
                _buildPaymentInfoItem('Betrag (USD)', '\$${info['amountUsd']}'),
                _buildPaymentInfoItem('Betrag (BTC)', '${info['amountBtc']} BTC'),
                _buildPaymentInfoItem('Memo', info['memo'] ?? '-'),
                const SizedBox(height: 16),
                const Text(
                  'Bitte sende den BTC-Betrag an die angegebene Adresse '
                  'und gib die Referenz (Memo) an. Nach der Zahlung, '
                  'gib die TX-ID ein.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Schließen'),
            ),
            if (order.paymentMethod == PaymentMethod.bitcoin)
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  _enterBitcoinTxId(order);
                },
                child: const Text('TX-ID eingeben'),
              ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    }
  }

  String _buildBitcoinQrData(Map<String, String> info) {
    final address = info['address'] ?? '';
    if (address.isEmpty) return '';

    final params = <String, String>{};
    final amountBtc = info['amountBtc'];
    final memo = info['memo'];

    if (amountBtc != null && amountBtc.isNotEmpty) {
      params['amount'] = amountBtc;
    }
    if (memo != null && memo.isNotEmpty) {
      params['message'] = memo;
      params['label'] = memo;
    }

    if (params.isEmpty) {
      return 'bitcoin:$address';
    }

    final query = params.entries
        .map((entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}')
        .join('&');
    return 'bitcoin:$address?$query';
  }

  Widget _buildPaymentInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SelectableText(value),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotCard(UserSlot slot) {
    final now = DateTime.now();
    final daysRemaining = slot.expiresAt.difference(now).inDays;
    final isExpiringSoon = daysRemaining <= 3 && daysRemaining >= 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
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
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slot.isUsed ? 'Slot genutzt' : 'Slot verfügbar',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Läuft ab: ${_formatDate(slot.expiresAt)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isExpiringSoon
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            if (isExpiringSoon)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text('$daysRemaining Tage'),
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                    fontSize: 12,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            IconButton(
              onPressed: () => _extendSlot(slot),
              icon: const Icon(Icons.add_circle_outline),
              tooltip: 'Verlängern',
            ),
          ],
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.confirmation_number,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
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
                    ],
                  ),
                ),
                Text(
                  '\$${(variant.priceUsdCents / 100).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '${variant.durationDays} Tage Laufzeit',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(width: 16),
                if (variant.allowPaypal) ...[
                  Icon(
                    Icons.payment,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'PayPal',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(width: 8),
                ],
                if (variant.allowBitcoin) ...[
                  Icon(
                    Icons.currency_bitcoin,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Bitcoin',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _buySlot(variant),
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Slot aktivieren'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _buySlot(SlotVariant variant) async {
    // Bestimme verfügbare Zahlungsmethoden
    final List<PaymentMethod> availableMethods = [];
    if (variant.allowPaypal) availableMethods.add(PaymentMethod.paypal);
    if (variant.allowBitcoin) availableMethods.add(PaymentMethod.bitcoin);

    if (availableMethods.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keine Zahlungsmethode verfügbar')),
      );
      return;
    }

    // Zeige Kauf-Dialog
    final selectedMethod = await showDialog<PaymentMethod>(
      context: context,
      builder: (context) => _SlotPurchaseDialog(
        variant: variant,
        availableMethods: availableMethods,
      ),
    );

    if (selectedMethod == null) return;

    try {
      // Erstelle Bestellung
      final order = await client.slotOrder.create(
        slotVariantId: variant.id!,
        paymentMethod: selectedMethod,
      );

      if (order != null && mounted) {
        // Zeige Zahlungsanweisungen
        _showPaymentInstructions(order, variant, selectedMethod);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    }
  }

  Future<void> _showPaymentInstructions(
    SlotOrder order,
    SlotVariant variant,
    PaymentMethod method,
  ) async {
    try {
      final info = await client.payment.getPaymentInfo(order.id!);

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(
            method == PaymentMethod.paypal ? Icons.payment : Icons.currency_bitcoin,
          ),
          title: Text(method == PaymentMethod.paypal ? 'PayPal-Zahlung' : 'Bitcoin-Zahlung'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bestellung #${order.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Betrag: \$${info['amount'] ?? (order.amountCents / 100).toStringAsFixed(2)}'),
                const Divider(height: 32),

                if (method == PaymentMethod.paypal) ...[
                  _buildPaymentInfoItem('PayPal-Adresse', info['email'] ?? '-'),
                  _buildPaymentInfoItem('Verwendungszweck', 'Order-${order.id}'),
                  const SizedBox(height: 16),
                  const Text(
                    'Bitte sende den Betrag an die angegebene PayPal-Adresse '
                    'und gib den Verwendungszweck an. Nach Zahlungseingang wird '
                    'dein Slot automatisch aktiviert.',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                  ),
                ] else ...[
                  // Bitcoin QR-Code
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: QrImageView(
                        data: _buildBitcoinQrData(info),
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPaymentInfoItem('Bitcoin-Adresse', info['address'] ?? '-'),
                  _buildPaymentInfoItem('Betrag (USD)', '\$${info['amountUsd'] ?? '-'}'),
                  _buildPaymentInfoItem('Betrag (BTC)', '${info['amountBtc'] ?? '-'} BTC'),
                  _buildPaymentInfoItem('Referenz (Memo)', info['memo'] ?? '-'),
                  const SizedBox(height: 16),
                  const Text(
                    'Scanne den QR-Code oder sende den BTC-Betrag an die angegebene '
                    'Adresse und gib die Referenz (Memo) an. Nach mindestens 1 '
                    'Bestätigung auf der Blockchain wird dein Slot automatisch aktiviert.',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            if (method == PaymentMethod.bitcoin)
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _enterBitcoinTxId(order);
                },
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('TX-ID eingeben'),
              ),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Schließen'),
            ),
          ],
        ),
      );

      // Lade die Daten neu, falls zwischenzeitlich bezahlt wurde
      _loadData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Laden der Zahlungsinformationen: $e')),
        );
      }
    }
  }

  Future<void> _extendSlot(UserSlot slot) async {
    // Verlängerung funktioniert wie ein normaler Kauf
    // Wähle eine Slot-Variante aus
    if (_slotVariants.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keine Slot-Varianten verfügbar')),
      );
      return;
    }

    final variant = await showDialog<SlotVariant>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Slot verlängern'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Wähle eine Slot-Variante, um deinen Slot zu verlängern. '
                'Die Laufzeit wird zum aktuellen Ablaufdatum hinzugefügt.',
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _slotVariants.length,
                  itemBuilder: (context, index) {
                    final v = _slotVariants[index];
                    return ListTile(
                      leading: const Icon(Icons.add_circle),
                      title: Text(v.name),
                      subtitle: Text('+${v.durationDays} Tage'),
                      trailing: Text('\$${(v.priceUsdCents / 100).toStringAsFixed(2)}'),
                      onTap: () => Navigator.pop(context, v),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
        ],
      ),
    );

    if (variant != null) {
      // Kaufe einen neuen Slot mit dieser Variante (funktioniert wie normaler Kauf)
      _buySlot(variant);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}

/// Dialog für Slot-Kauf mit Zahlungsmethoden-Auswahl.
class _SlotPurchaseDialog extends StatefulWidget {
  final SlotVariant variant;
  final List<PaymentMethod> availableMethods;

  const _SlotPurchaseDialog({
    required this.variant,
    required this.availableMethods,
  });

  @override
  State<_SlotPurchaseDialog> createState() => _SlotPurchaseDialogState();
}

class _SlotPurchaseDialogState extends State<_SlotPurchaseDialog> {
  PaymentMethod? _selectedMethod;

  @override
  void initState() {
    super.initState();
    if (widget.availableMethods.isNotEmpty) {
      _selectedMethod = widget.availableMethods.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.shopping_cart),
      title: const Text('Slot kaufen'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Slot-Details
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.confirmation_number,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.variant.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '${widget.variant.durationDays} Tage Laufzeit',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${(widget.variant.priceUsdCents / 100).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Zahlungsmethode
          Text(
            'Zahlungsmethode',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ...widget.availableMethods.map((method) {
            return RadioListTile<PaymentMethod>(
              value: method,
              groupValue: _selectedMethod,
              onChanged: (value) => setState(() => _selectedMethod = value),
              title: Text(method == PaymentMethod.paypal ? 'PayPal' : 'Bitcoin'),
              secondary: Icon(
                method == PaymentMethod.paypal ? Icons.payment : Icons.currency_bitcoin,
              ),
              dense: true,
              contentPadding: EdgeInsets.zero,
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Abbrechen'),
        ),
        FilledButton(
          onPressed: _selectedMethod == null
              ? null
              : () => Navigator.pop(context, _selectedMethod),
          child: const Text('Kaufen'),
        ),
      ],
    );
  }
}
