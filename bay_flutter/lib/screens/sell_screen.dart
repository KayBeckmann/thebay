import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../l10n/app_localizations.dart';
import '../main.dart';
import '../utils/date_formatter.dart';
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

  // Alle Slot-Varianten (für Zuordnung)
  Map<int, SlotVariant> _allVariantsMap = {};

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
      final activeVariants = await client.slotVariant.getActive();
      final allVariants = await client.slotVariant.getAll();
      if (mounted) {
        setState(() {
          _slotVariants = activeVariants;
          _allVariantsMap = {for (var v in allVariants) v.id!: v};
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
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteListing),
        content: Text(l10n.deleteListingConfirm(listing.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await client.listing.delete(listing.id!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.listingDeleted)),
          );
          _loadData();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.error(e.toString()))),
          );
        }
      }
    }
  }

  void _showNoSlotsDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.info_outline),
        title: Text(l10n.noAvailableSlots),
        content: Text(l10n.noSlotsMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _tabController.animateTo(1);
            },
            child: Text(l10n.showSlots),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.sell),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.myListings(_myListings.length)),
            Tab(text: l10n.mySlots(_availableSlots)),
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
        label: Text(l10n.newListing),
      ),
    );
  }

  Widget _buildMyListingsTab() {
    final l10n = AppLocalizations.of(context)!;
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
                l10n.noListings,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.noListingsMessage,
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
                  label: Text(l10n.createFirstListing),
                )
              else
                FilledButton.icon(
                  onPressed: () => _tabController.animateTo(1),
                  icon: const Icon(Icons.shopping_cart),
                  label: Text(l10n.buySlots),
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
    final l10n = AppLocalizations.of(context)!;
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
              l10n.pendingOrders,
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
            l10n.activeSlots,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          _buildActiveSlotsSection(),
          const SizedBox(height: 24),

          // Slots kaufen
          Text(
            l10n.buySlots,
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
    final l10n = AppLocalizations.of(context)!;
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
              l10n.available,
              '${_slotStats['available'] ?? 0}',
              Icons.check_circle,
              Colors.green,
            ),
            _buildStatItem(
              context,
              l10n.used,
              '${_slotStats['used'] ?? 0}',
              Icons.inventory,
              Theme.of(context).colorScheme.primary,
            ),
            _buildStatItem(
              context,
              l10n.expired,
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
    final l10n = AppLocalizations.of(context)!;
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
              l10n.noActiveSlots,
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
    final l10n = AppLocalizations.of(context)!;
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
                        l10n.orderNumber(order.id!),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        order.paymentMethod == PaymentMethod.paypal
                            ? l10n.paypalWaitingForPayment
                            : l10n.bitcoinWaitingForConfirmation,
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
                  l10n.createdLabel(DateFormatter.formatDate(context,order.createdAt)),
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
                  child: Text(l10n.cancel),
                ),
                const SizedBox(width: 8),
                if (order.paymentMethod == PaymentMethod.bitcoin)
                  OutlinedButton.icon(
                    onPressed: () => _enterBitcoinTxId(order),
                    icon: const Icon(Icons.edit, size: 16),
                    label: Text(l10n.enterTxId),
                  ),
                if (order.paymentMethod == PaymentMethod.bitcoin)
                  const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () => _viewPaymentDetails(order),
                  icon: const Icon(Icons.info_outline, size: 16),
                  label: Text(l10n.pay),
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
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.cancelOrder),
        content: Text(
          l10n.cancelOrderConfirm(order.id!),
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
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await client.slotOrder.cancel(order.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.orderCanceled)),
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
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: order.transactionId ?? '');

    final txId = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.currency_bitcoin),
        title: Text(l10n.bitcoinTransactionId),
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
              decoration: InputDecoration(
                labelText: l10n.txIdLabel,
                hintText: l10n.txIdPlaceholder,
                prefixIcon: const Icon(Icons.tag),
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
            child: Text(l10n.save),
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
          SnackBar(content: Text(l10n.txIdSaved)),
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
    final l10n = AppLocalizations.of(context)!;
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
                ? l10n.paypalPayment
                : l10n.bitcoinPayment,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (order.paymentMethod == PaymentMethod.paypal) ...[
                _buildPaymentInfoItem(l10n.recipient, info['email'] ?? '-'),
                _buildPaymentInfoItem(l10n.amount, '\$${info['amount']}'),
                _buildPaymentInfoItem(l10n.reference, 'Order-${order.id}'),
                const SizedBox(height: 16),
                const Text(
                  'Bitte sende den Betrag an die angegebene PayPal-Adresse '
                  'und gib den Verwendungszweck an.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ] else ...[
                _buildPaymentInfoItem(l10n.address, info['address'] ?? '-'),
                _buildPaymentInfoItem(l10n.amountUsd, '\$${info['amountUsd']}'),
                _buildPaymentInfoItem(l10n.amountBtc, '${info['amountBtc']} BTC'),
                _buildPaymentInfoItem(l10n.memo, info['memo'] ?? '-'),
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
              child: Text(l10n.close),
            ),
            if (order.paymentMethod == PaymentMethod.bitcoin)
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  _enterBitcoinTxId(order);
                },
                child: Text(l10n.enterTxId),
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
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final daysRemaining = slot.expiresAt.difference(now).inDays;
    final isExpiringSoon = daysRemaining <= 3 && daysRemaining >= 0;
    final slotVariant = _allVariantsMap[slot.slotVariantId];
    final isFreeSlot = slotVariant?.isFree ?? false;

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
                    slot.isUsed ? l10n.slotUsed : l10n.slotAvailable,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.expiresOn(DateFormatter.formatDate(context,slot.expiresAt)),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isExpiringSoon
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            if (isFreeSlot)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text(l10n.free),
                  backgroundColor: Colors.green.withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            if (isExpiringSoon)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text(l10n.daysRemaining(daysRemaining)),
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
              tooltip: l10n.extend,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuySlotSection() {
    final l10n = AppLocalizations.of(context)!;
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
                l10n.noSlotVariantsAvailable,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.adminMustConfigureSlots,
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
    final l10n = AppLocalizations.of(context)!;
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
                  l10n.daysValidity(variant.durationDays),
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
                label: Text(l10n.activateSlot),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _buySlot(SlotVariant variant) async {
    final l10n = AppLocalizations.of(context)!;
    // Bestimme verfügbare Zahlungsmethoden
    final List<PaymentMethod> availableMethods = [];
    if (variant.allowPaypal) availableMethods.add(PaymentMethod.paypal);
    if (variant.allowBitcoin) availableMethods.add(PaymentMethod.bitcoin);

    if (availableMethods.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.noPaymentMethod)),
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
    final l10n = AppLocalizations.of(context)!;
    try {
      final info = await client.payment.getPaymentInfo(order.id!);

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(
            method == PaymentMethod.paypal ? Icons.payment : Icons.currency_bitcoin,
          ),
          title: Text(method == PaymentMethod.paypal ? l10n.paypalPayment : l10n.bitcoinPayment),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.orderNumber(order.id!),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Betrag: \$${info['amount'] ?? (order.amountCents / 100).toStringAsFixed(2)}'),
                const Divider(height: 32),

                if (method == PaymentMethod.paypal) ...[
                  _buildPaymentInfoItem(l10n.paypalAddress, info['email'] ?? '-'),
                  _buildPaymentInfoItem(l10n.reference, 'Order-${order.id}'),
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
                  _buildPaymentInfoItem(l10n.bitcoinAddress, info['address'] ?? '-'),
                  _buildPaymentInfoItem(l10n.amountUsd, '\$${info['amountUsd'] ?? '-'}'),
                  _buildPaymentInfoItem(l10n.amountBtc, '${info['amountBtc'] ?? '-'} BTC'),
                  _buildPaymentInfoItem(l10n.referenceLabel, info['memo'] ?? '-'),
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
                label: Text(l10n.enterTxId),
              ),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.close),
            ),
          ],
        ),
      );

      // Lade die Daten neu, falls zwischenzeitlich bezahlt wurde
      _loadData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorLoadingPaymentInfo(e.toString()))),
        );
      }
    }
  }

  Future<void> _extendSlot(UserSlot slot) async {
    final l10n = AppLocalizations.of(context)!;
    // Verlängerung funktioniert wie ein normaler Kauf
    // Wähle eine Slot-Variante aus
    if (_slotVariants.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.noSlotVariantsAvailable)),
      );
      return;
    }

    final variant = await showDialog<SlotVariant>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.extendSlot),
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
                      subtitle: Text(l10n.daysRemaining(v.durationDays)),
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
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      icon: const Icon(Icons.shopping_cart),
      title: Text(l10n.buySlot),
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
            l10n.paymentMethod,
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
          child: Text(l10n.buy),
        ),
      ],
    );
  }
}
