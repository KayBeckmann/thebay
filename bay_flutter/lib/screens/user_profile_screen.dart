import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../main.dart' show client, authService;
import '../widgets/report_dialog.dart';
import 'listings/listing_card.dart';
import 'messages_screen.dart' show showComposeMessageDialog;
import 'ratings/ratings_list_widget.dart';

/// Screen für öffentliche Benutzerprofile.
class UserProfileScreen extends StatefulWidget {
  final int userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  UserProfile? _profile;
  List<Listing> _listings = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _error;
  int _offset = 0;
  static const int _limit = 10;
  bool _hasMore = true;
  late TabController _tabController;

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
    setState(() {
      _isLoading = true;
      _error = null;
      _offset = 0;
      _hasMore = true;
    });

    try {
      final profile = await client.userProfile.getProfile(widget.userId);
      if (profile == null) {
        if (mounted) {
          throw Exception(AppLocalizations.of(context)!.userNotFound);
        }
        return;
      }

      final listings = await client.userProfile.getUserListings(
        widget.userId,
        limit: _limit,
        offset: 0,
      );

      if (mounted) {
        setState(() {
          _profile = profile;
          _listings = listings;
          _isLoading = false;
          _hasMore = listings.length >= _limit;
          _offset = listings.length;
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

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final listings = await client.userProfile.getUserListings(
        widget.userId,
        limit: _limit,
        offset: _offset,
      );

      if (mounted) {
        setState(() {
          _listings.addAll(listings);
          _offset += listings.length;
          _hasMore = listings.length >= _limit;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_profile?.username ?? l10n.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag),
            tooltip: l10n.reportUser,
            onPressed: _profile != null ? () => _showReportDialog() : null,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(l10n.errorLoading(_error!)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadData,
              child: Text(l10n.retryButton),
            ),
          ],
        ),
      );
    }

    if (_profile == null) {
      return Center(child: Text(l10n.userNotFound));
    }

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          // Profil-Header
          SliverToBoxAdapter(
            child: _buildProfileHeader(),
          ),

          // Statistiken
          SliverToBoxAdapter(
            child: _buildStats(),
          ),

          // Zahlungsinformationen (falls Kontakt besteht)
          if (_profile!.hasContact &&
              (_profile!.paypalAddress != null || _profile!.bitcoinWallet != null))
            SliverToBoxAdapter(
              child: _buildPaymentInfo(),
            ),

          // Aktionen
          SliverToBoxAdapter(
            child: _buildActions(),
          ),

          // Tab Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.inventory_2),
                    text: l10n.listingsWithCount(_profile!.activeListingsCount),
                  ),
                  Tab(
                    icon: const Icon(Icons.star),
                    text: l10n.ratingsWithCount(_profile!.ratingCount),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          // Listings Tab
          _buildListingsTab(),
          // Ratings Tab
          _buildRatingsTab(),
        ],
      ),
    );
  }

  Widget _buildListingsTab() {
    final l10n = AppLocalizations.of(context)!;

    if (_listings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noActiveListings,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _listings.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _listings.length) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ListingCard(listing: _listings[index]),
            );
          }
          // Load more indicator
          if (_hasMore) {
            _loadMore();
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRatingsTab() {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: RatingsListWidget(userId: widget.userId),
      ),
    );
  }

  Widget _buildProfileHeader() {
    final l10n = AppLocalizations.of(context)!;
    final isOwnProfile = authService.currentUser?.userId == widget.userId;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              _profile!.username.substring(0, 1).toUpperCase(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
          const SizedBox(width: 16),

          // Benutzerinfo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _profile!.username,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (isOwnProfile) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          l10n.you,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.memberSince(_formatDate(_profile!.memberSince, l10n)),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                if (_profile!.hasPgpKey) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.verified_user,
                        size: 16,
                        color: Colors.green.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.encryptionActive,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.green.shade600,
                            ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final l10n = AppLocalizations.of(context)!;
    final ratingPercentage = _profile!.ratingAverage;
    final ratingColor = ratingPercentage != null
        ? (ratingPercentage >= 90
            ? Colors.green
            : ratingPercentage >= 70
                ? Colors.lightGreen
                : ratingPercentage >= 50
                    ? Colors.orange
                    : Colors.red)
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.inventory_2,
                  value: _profile!.activeListingsCount.toString(),
                  label: l10n.listings,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              Expanded(
                child: InkWell(
                  onTap: () => _tabController.animateTo(1),
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            ratingPercentage != null && ratingPercentage >= 70
                                ? Icons.thumb_up
                                : Icons.star,
                            color: ratingColor,
                          ),
                          if (ratingPercentage != null) ...[
                            const SizedBox(width: 4),
                            Text(
                              '${ratingPercentage.toStringAsFixed(0)}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ratingColor,
                                  ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _profile!.ratingCount == 0
                            ? l10n.noRatings
                            : l10n.ratingCount(_profile!.ratingCount),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.payment),
                  const SizedBox(width: 8),
                  Text(
                    l10n.paymentInformation,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_profile!.paypalAddress != null) ...[
                _buildPaymentRow(
                  icon: Icons.paypal,
                  label: l10n.paypal,
                  value: _profile!.paypalAddress!,
                ),
                const SizedBox(height: 8),
              ],
              if (_profile!.bitcoinWallet != null)
                _buildPaymentRow(
                  icon: Icons.currency_bitcoin,
                  label: l10n.bitcoin,
                  value: _profile!.bitcoinWallet!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Expanded(
          child: SelectableText(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    final l10n = AppLocalizations.of(context)!;
    final isOwnProfile = authService.currentUser?.userId == widget.userId;

    if (isOwnProfile) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: _profile!.hasPgpKey ? _sendMessage : null,
          icon: const Icon(Icons.message),
          label: Text(
            _profile!.hasPgpKey ? l10n.sendMessage : l10n.noPgpKeyAvailable,
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    showComposeMessageDialog(
      context,
      recipientId: widget.userId,
    );
  }

  Future<void> _showReportDialog() async {
    if (_profile == null) return;

    await showDialog(
      context: context,
      builder: (context) => ReportDialog(
        targetType: ReportTargetType.user,
        targetId: widget.userId,
        targetName: _profile!.username,
      ),
    );
  }

  String _formatDate(DateTime date, AppLocalizations l10n) {
    final months = [
      l10n.monthJan, l10n.monthFeb, l10n.monthMar, l10n.monthApr,
      l10n.monthMay, l10n.monthJun, l10n.monthJul, l10n.monthAug,
      l10n.monthSep, l10n.monthOct, l10n.monthNov, l10n.monthDec,
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
