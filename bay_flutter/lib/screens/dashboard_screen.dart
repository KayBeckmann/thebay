import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../main.dart';
import '../services/auth_service.dart';
import 'listings/listing_detail_screen.dart';
import 'transactions/transaction_detail_screen.dart';

/// Dashboard screen showing news and recent listings.
class DashboardScreen extends StatefulWidget {
  final AuthService authService;

  const DashboardScreen({
    super.key,
    required this.authService,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const int _recentListingsLimit = 6;
  List<News> _news = [];
  List<Transaction> _pendingRatings = [];
  List<UserSlot> _expiringSlots = [];
  List<Listing> _recentListings = [];
  bool _isLoadingNews = true;
  bool _isLoadingRatings = true;
  bool _isLoadingSlots = true;
  bool _isLoadingListings = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadNews(),
      _loadPendingRatings(),
      _loadSlotWarnings(),
      _loadRecentListings(),
    ]);
  }

  Future<void> _loadNews() async {
    setState(() => _isLoadingNews = true);

    try {
      final news = await client.news.getPublished();
      if (mounted) {
        setState(() {
          _news = news;
          _isLoadingNews = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingNews = false);
      }
    }
  }

  Future<void> _loadPendingRatings() async {
    setState(() => _isLoadingRatings = true);

    try {
      final transactions = await client.rating.getPendingRatingTransactions();
      if (mounted) {
        setState(() {
          _pendingRatings = transactions;
          _isLoadingRatings = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingRatings = false);
      }
    }
  }

  Future<void> _loadSlotWarnings() async {
    setState(() => _isLoadingSlots = true);

    try {
      final slots = await client.userSlot.getExpiringSoon(days: 3);
      if (mounted) {
        setState(() {
          _expiringSlots = slots;
          _isLoadingSlots = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingSlots = false);
      }
    }
  }

  Future<void> _loadRecentListings() async {
    setState(() => _isLoadingListings = true);

    try {
      final listings =
          await client.listing.getActive(limit: _recentListingsLimit, offset: 0);
      if (mounted) {
        setState(() {
          _recentListings = listings;
          _isLoadingListings = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingListings = false);
      }
    }
  }

  Future<void> _refresh() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = widget.authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardTitle),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Welcome message
            _buildWelcomeCard(context, user?.username),
            const SizedBox(height: 16),

            // Pending ratings section
            if (_pendingRatings.isNotEmpty) ...[
              _buildSectionHeader(context, l10n.sectionPendingRatings),
              const SizedBox(height: 8),
              _buildPendingRatingsSection(context),
              const SizedBox(height: 24),
            ],

            // News section
            _buildSectionHeader(context, l10n.sectionNews),
            const SizedBox(height: 8),
            _buildNewsSection(context),
            const SizedBox(height: 24),

            // Slot warnings section
            _buildSectionHeader(context, l10n.sectionSlotWarnings),
            const SizedBox(height: 8),
            _buildSlotWarningsSection(context),
            const SizedBox(height: 24),

            // Recent listings section
            _buildSectionHeader(context, l10n.sectionRecentListings),
            const SizedBox(height: 8),
            _buildRecentListingsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context, String? username) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.waving_hand,
                size: 28,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.welcomeUser(username ?? l10n.userFallback),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.whatTodayQuestion,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildNewsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoadingNews) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_news.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.campaign,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.noNews,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.noNewsMessage,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: _news.take(3).map((news) => _buildNewsCard(news)).toList(),
    );
  }

  Widget _buildNewsCard(News news) {
    final formattedDate = news.publishedAt != null
        ? '${news.publishedAt!.day.toString().padLeft(2, '0')}.${news.publishedAt!.month.toString().padLeft(2, '0')}.${news.publishedAt!.year}'
        : '';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.campaign,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    news.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              news.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingRatingsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoadingRatings) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.pendingRatingsCount(_pendingRatings.length),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._pendingRatings.take(3).map((transaction) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailScreen(
                          transactionId: transaction.id!,
                          onStatusChanged: _loadPendingRatings,
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.receipt_long, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.transactionNumber(transaction.id!),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            if (_pendingRatings.length > 3)
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to transactions screen
                  },
                  child: Text(l10n.viewAllPendingRatings(_pendingRatings.length)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotWarningsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoadingSlots) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_expiringSlots.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.noSlotsExpiring,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.slotsExpiringSoon(_expiringSlots.length),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onErrorContainer,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._expiringSlots.take(3).map((slot) {
              final daysLeft =
                  slot.expiresAt.difference(DateTime.now()).inDays;
              final listingInfo = slot.listingId != null
                  ? l10n.listingNumber(slot.listingId!)
                  : l10n.noListingLinked;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 18,
                      color: Theme.of(context)
                          .colorScheme
                          .onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${l10n.slotNumber(slot.id!)} • $listingInfo • ${_formatDate(slot.expiresAt)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                            ),
                      ),
                    ),
                    Text(
                      '${daysLeft < 0 ? 0 : daysLeft}d',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onErrorContainer,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              );
            }),
            if (_expiringSlots.length > 3)
              Text(
                l10n.moreCount(_expiringSlots.length - 3),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentListingsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoadingListings) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_recentListings.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.noListingsYet,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.noListingsMessage,
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
      children:
          _recentListings.map((listing) => _buildRecentListingRow(listing)).toList(),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  Widget _buildRecentListingRow(Listing listing) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Icon(
          Icons.inventory_2_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        title: Text(
          listing.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          _formatListingPrice(listing),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onTap: () => _openListingDetail(listing.id!),
      ),
    );
  }

  String _formatListingPrice(Listing listing) {
    final currency =
        listing.acceptsBitcoin && !listing.acceptsPaypal ? 'BTC' : 'USD';
    final price = listing.pricePerUnit / 100;
    final unitLabel = _quantityUnitLabel(context, listing.quantityUnit);
    if (unitLabel.isEmpty) {
      return '${price.toStringAsFixed(2)} $currency';
    }
    return '${price.toStringAsFixed(2)} $currency/$unitLabel';
  }

  String _quantityUnitLabel(BuildContext context, QuantityUnit unit) {
    final l10n = AppLocalizations.of(context)!;
    switch (unit) {
      case QuantityUnit.piece:
        return l10n.unitPiece;
      case QuantityUnit.kg:
        return l10n.unitKg;
      case QuantityUnit.gram:
        return l10n.unitGram;
      case QuantityUnit.meter:
        return l10n.unitMeter;
      case QuantityUnit.liter:
        return l10n.unitLiter;
      case QuantityUnit.none:
        return '';
    }
  }

  void _openListingDetail(int listingId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListingDetailScreen(listingId: listingId),
      ),
    );
  }
}
