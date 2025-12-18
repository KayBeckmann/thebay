import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/auth_service.dart';
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
  List<News> _news = [];
  List<Transaction> _pendingRatings = [];
  bool _isLoadingNews = true;
  bool _isLoadingRatings = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadNews(),
      _loadPendingRatings(),
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

  Future<void> _refresh() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
              _buildSectionHeader(context, 'Pending Ratings'),
              const SizedBox(height: 8),
              _buildPendingRatingsSection(context),
              const SizedBox(height: 24),
            ],

            // News section
            _buildSectionHeader(context, 'News'),
            const SizedBox(height: 8),
            _buildNewsSection(context),
            const SizedBox(height: 24),

            // Slot warnings section
            _buildSectionHeader(context, 'Slot Warnings'),
            const SizedBox(height: 8),
            _buildSlotWarningsSection(context),
            const SizedBox(height: 24),

            // Recent listings section
            _buildSectionHeader(context, 'Recent Listings'),
            const SizedBox(height: 8),
            _buildRecentListingsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context, String? username) {
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
                    'Willkommen, ${username ?? 'Benutzer'}!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Was möchtest du heute tun?',
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
                      'Keine Neuigkeiten',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Aktuell gibt es keine Neuigkeiten. Schau später wieder vorbei!',
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
                    'You have ${_pendingRatings.length} pending rating${_pendingRatings.length == 1 ? '' : 's'}',
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
                            'Transaction #${transaction.id}',
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
                  child: Text('View all ${_pendingRatings.length} pending ratings'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotWarningsSection(BuildContext context) {
    // TODO: Load slot warnings from server
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
                'Keine Slots laufen in den nächsten 3 Tagen ab.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentListingsSection(BuildContext context) {
    // TODO: Load recent listings from server
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
              'Noch keine Angebote',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Hier werden die neuesten Angebote angezeigt.',
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
}
