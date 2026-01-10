import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart' show client;
import '../../utils/date_formatter.dart';

/// Widget zur Anzeige einer Liste von Bewertungen für einen Benutzer.
class RatingsListWidget extends StatefulWidget {
  final int userId;
  final int initialLimit;

  const RatingsListWidget({
    super.key,
    required this.userId,
    this.initialLimit = 5,
  });

  @override
  State<RatingsListWidget> createState() => _RatingsListWidgetState();
}

class _RatingsListWidgetState extends State<RatingsListWidget> {
  List<Rating> _ratings = [];
  RatingStats? _stats;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _error;
  int _offset = 0;
  bool _hasMore = true;
  bool _showAll = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final stats = await client.rating.getUserStats(widget.userId);
      final ratings = await client.rating.getByUser(
        widget.userId,
        limit: widget.initialLimit,
        offset: 0,
      );

      if (mounted) {
        setState(() {
          _stats = stats;
          _ratings = ratings;
          _isLoading = false;
          _hasMore = ratings.length >= widget.initialLimit;
          _offset = ratings.length;
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

    setState(() => _isLoadingMore = true);

    try {
      final ratings = await client.rating.getByUser(
        widget.userId,
        limit: 10,
        offset: _offset,
      );

      if (mounted) {
        setState(() {
          _ratings.addAll(ratings);
          _offset += ratings.length;
          _hasMore = ratings.length >= 10;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_error != null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.error_outline,
                  color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 8),
              Text(l10n.errorLoadingRatings),
              TextButton(
                onPressed: _loadData,
                child: Text(l10n.retryButton),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats Card
        if (_stats != null) _buildStatsCard(),
        const SizedBox(height: 16),

        // Ratings List
        if (_ratings.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.star_border,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.noRatingsYet,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.noRatingsDescription,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          ..._buildRatingsList(),
      ],
    );
  }

  Widget _buildStatsCard() {
    final l10n = AppLocalizations.of(context)!;
    final positivePercentage = _stats!.positivePercentage;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Main Rating Display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (positivePercentage != null) ...[
                  Icon(
                    _getRatingIcon(positivePercentage),
                    size: 48,
                    color: _getRatingColor(positivePercentage),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${positivePercentage.toStringAsFixed(0)}%',
                        style:
                            Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: _getRatingColor(positivePercentage),
                                ),
                      ),
                      Text(
                        l10n.positive,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ] else ...[
                  Icon(
                    Icons.star_border,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    l10n.noRatingsYet,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // Breakdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(
                  icon: Icons.thumb_up,
                  color: Colors.green,
                  count: _stats!.positiveCount,
                  label: l10n.ratingGood,
                ),
                _buildStatItem(
                  icon: Icons.thumbs_up_down,
                  color: Colors.orange,
                  count: _stats!.neutralCount,
                  label: l10n.ratingNeutral,
                ),
                _buildStatItem(
                  icon: Icons.thumb_down,
                  color: Colors.red,
                  count: _stats!.negativeCount,
                  label: l10n.ratingBad,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color color,
    required int count,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  List<Widget> _buildRatingsList() {
    final l10n = AppLocalizations.of(context)!;
    final displayedRatings = _showAll ? _ratings : _ratings.take(widget.initialLimit).toList();

    return [
      ...displayedRatings.map((rating) => _RatingCard(rating: rating)),
      if (!_showAll && _ratings.length > widget.initialLimit)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: TextButton(
              onPressed: () => setState(() => _showAll = true),
              child: Text(
                l10n.showAllRatings(_stats?.totalCount ?? _ratings.length),
              ),
            ),
          ),
        ),
      if (_showAll && _hasMore)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: _isLoadingMore
                ? const CircularProgressIndicator()
                : TextButton(
                    onPressed: _loadMore,
                    child: Text(l10n.loadMore),
                  ),
          ),
        ),
    ];
  }

  IconData _getRatingIcon(double percentage) {
    if (percentage >= 90) return Icons.verified;
    if (percentage >= 70) return Icons.thumb_up;
    if (percentage >= 50) return Icons.thumbs_up_down;
    return Icons.thumb_down;
  }

  Color _getRatingColor(double percentage) {
    if (percentage >= 90) return Colors.green;
    if (percentage >= 70) return Colors.lightGreen;
    if (percentage >= 50) return Colors.orange;
    return Colors.red;
  }
}

/// Karte für eine einzelne Bewertung.
class _RatingCard extends StatefulWidget {
  final Rating rating;

  const _RatingCard({required this.rating});

  @override
  State<_RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<_RatingCard> {
  String? _fromUsername;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    try {
      final username =
          await client.userProfile.getUsername(widget.rating.fromUserId);
      if (mounted) {
        setState(() => _fromUsername = username);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ratingInfo = _getRatingInfo(widget.rating.rating, l10n);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ratingInfo.color.withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ratingInfo.icon,
                    size: 20,
                    color: ratingInfo.color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _fromUsername ?? 'User #${widget.rating.fromUserId}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          if (widget.rating.isAutomatic) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                l10n.auto,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        DateFormatter.formatDate(context,widget.rating.createdAt),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ratingInfo.color.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    ratingInfo.label,
                    style: TextStyle(
                      color: ratingInfo.color,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            // Comment
            if (widget.rating.comment != null &&
                widget.rating.comment!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                widget.rating.comment!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  _RatingInfo _getRatingInfo(RatingValue rating, AppLocalizations l10n) {
    switch (rating) {
      case RatingValue.positive:
        return _RatingInfo(
          label: l10n.ratingGood,
          icon: Icons.thumb_up,
          color: Colors.green,
        );
      case RatingValue.neutral:
        return _RatingInfo(
          label: l10n.ratingNeutral,
          icon: Icons.thumbs_up_down,
          color: Colors.orange,
        );
      case RatingValue.negative:
        return _RatingInfo(
          label: l10n.ratingBad,
          icon: Icons.thumb_down,
          color: Colors.red,
        );
    }
  }
}

class _RatingInfo {
  final String label;
  final IconData icon;
  final Color color;

  _RatingInfo({
    required this.label,
    required this.icon,
    required this.color,
  });
}
