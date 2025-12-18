import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart' show client, authService;
import '../user_profile_screen.dart';
import '../listings/listing_detail_screen.dart';
import '../ratings/submit_rating_dialog.dart';

/// Detailansicht für eine Transaktion.
class TransactionDetailScreen extends StatefulWidget {
  final int transactionId;
  final VoidCallback? onStatusChanged;

  const TransactionDetailScreen({
    super.key,
    required this.transactionId,
    this.onStatusChanged,
  });

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  Transaction? _transaction;
  Listing? _listing;
  Dispute? _dispute;
  String? _buyerUsername;
  String? _sellerUsername;
  bool _isLoading = true;
  bool _isActionLoading = false;
  String? _error;
  bool _canRate = false;
  bool _hasRated = false;

  int? get _currentUserId => authService.currentUser?.userId;
  bool get _isBuyer => _transaction?.buyerId == _currentUserId;
  bool get _isSeller => _transaction?.sellerId == _currentUserId;

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
      final transaction =
          await client.transaction.getById(widget.transactionId);
      if (transaction == null) {
        throw Exception('Transaction not found');
      }

      Listing? listing;
      try {
        listing = await client.listing.getById(transaction.listingId);
      } catch (_) {
        // Listing might be deleted
      }

      Dispute? dispute;
      if (transaction.status == TransactionStatus.disputed) {
        try {
          final disputes =
              await client.dispute.getByTransaction(transaction.id!);
          if (disputes.isNotEmpty) {
            dispute = disputes.first;
          }
        } catch (_) {
          // No dispute found
        }
      }

      final buyerUsername =
          await client.userProfile.getUsername(transaction.buyerId);
      final sellerUsername =
          await client.userProfile.getUsername(transaction.sellerId);

      // Check if user can rate this transaction
      bool canRate = false;
      bool hasRated = false;
      if (transaction.status == TransactionStatus.completed) {
        try {
          canRate = await client.rating.canRateTransaction(transaction.id!);
          hasRated = !canRate;
        } catch (_) {}
      }

      if (mounted) {
        setState(() {
          _transaction = transaction;
          _listing = listing;
          _dispute = dispute;
          _buyerUsername = buyerUsername;
          _sellerUsername = sellerUsername;
          _canRate = canRate;
          _hasRated = hasRated;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_transaction != null
            ? 'Transaction #${_transaction!.id}'
            : 'Transaction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _buildBody(),
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
            Text('Error: $_error'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_transaction == null) {
      return const Center(child: Text('Transaction not found'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Card
          _buildStatusCard(),
          const SizedBox(height: 16),

          // Rating Prompt (for completed transactions)
          if (_transaction!.status == TransactionStatus.completed && _canRate)
            _buildRatingPrompt(),

          // Already Rated Info
          if (_transaction!.status == TransactionStatus.completed && _hasRated)
            _buildAlreadyRatedCard(),

          // Timeline
          _buildTimeline(),
          const SizedBox(height: 16),

          // Auto-complete Warning
          if (_transaction!.status == TransactionStatus.shipped &&
              _transaction!.autoCompleteAt != null)
            _buildAutoCompleteWarning(),

          // Dispute Info
          if (_transaction!.status == TransactionStatus.disputed &&
              _dispute != null) ...[
            _buildDisputeCard(),
            const SizedBox(height: 16),
          ],

          // Actions
          _buildActionButtons(),
          const SizedBox(height: 24),

          // Transaction Details
          _buildDetailsCard(),
          const SizedBox(height: 16),

          // Parties
          _buildPartiesCard(),
          const SizedBox(height: 16),

          // Listing Info
          if (_listing != null) ...[
            _buildListingCard(),
            const SizedBox(height: 16),
          ],

          // Buyer Note
          if (_transaction!.buyerNote != null &&
              _transaction!.buyerNote!.isNotEmpty) ...[
            _buildBuyerNoteCard(),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildRatingPrompt() {
    final partnerUsername = _isBuyer ? _sellerUsername : _buyerUsername;

    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Rate this transaction',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Share your experience with ${partnerUsername ?? 'the other party'}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _openRatingDialog,
                icon: const Icon(Icons.rate_review),
                label: const Text('Rate Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlreadyRatedCard() {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'You have already rated this transaction',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openRatingDialog() async {
    final partnerUsername = _isBuyer ? _sellerUsername : _buyerUsername;

    final result = await showSubmitRatingDialog(
      context,
      transactionId: _transaction!.id!,
      partnerUsername: partnerUsername ?? 'Unknown',
      isBuyer: _isBuyer,
    );

    if (result != null) {
      await _loadData();
    }
  }

  Widget _buildStatusCard() {
    final statusInfo = _getStatusInfo(_transaction!.status);

    return Card(
      color: statusInfo.color.withAlpha(30),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: statusInfo.color.withAlpha(50),
                shape: BoxShape.circle,
              ),
              child: Icon(
                statusInfo.icon,
                size: 32,
                color: statusInfo.color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusInfo.label,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: statusInfo.color,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    statusInfo.description,
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

  Widget _buildTimeline() {
    final steps = <_TimelineStep>[
      _TimelineStep(
        title: 'Created',
        subtitle: _formatDateTime(_transaction!.createdAt),
        isCompleted: true,
        icon: Icons.add_circle,
      ),
      _TimelineStep(
        title: 'Shipped',
        subtitle: _transaction!.shippedAt != null
            ? _formatDateTime(_transaction!.shippedAt!)
            : 'Waiting for seller',
        isCompleted: _transaction!.shippedAt != null,
        icon: Icons.local_shipping,
      ),
      _TimelineStep(
        title: 'Received',
        subtitle: _transaction!.receivedAt != null
            ? _formatDateTime(_transaction!.receivedAt!)
            : 'Waiting for buyer',
        isCompleted: _transaction!.receivedAt != null,
        icon: Icons.inbox,
      ),
      _TimelineStep(
        title: 'Completed',
        subtitle: _transaction!.completedAt != null
            ? _formatDateTime(_transaction!.completedAt!)
            : _transaction!.status == TransactionStatus.cancelled
                ? 'Cancelled'
                : 'Pending',
        isCompleted: _transaction!.completedAt != null,
        isCancelled: _transaction!.status == TransactionStatus.cancelled,
        icon: _transaction!.status == TransactionStatus.cancelled
            ? Icons.cancel
            : Icons.check_circle,
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timeline',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isLast = index == steps.length - 1;

              return _buildTimelineItem(step, isLast);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(_TimelineStep step, bool isLast) {
    final color = step.isCancelled
        ? Colors.grey
        : step.isCompleted
            ? Colors.green
            : Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(100);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withAlpha(step.isCompleted ? 255 : 50),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  step.icon,
                  size: 18,
                  color: step.isCompleted ? Colors.white : color,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: color.withAlpha(100),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: step.isCompleted
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  Text(
                    step.subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoCompleteWarning() {
    final daysLeft =
        _transaction!.autoCompleteAt!.difference(DateTime.now()).inDays;
    final isUrgent = daysLeft <= 3;

    return Card(
      color: isUrgent
          ? Theme.of(context).colorScheme.errorContainer
          : Theme.of(context).colorScheme.tertiaryContainer,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.schedule,
              color: isUrgent
                  ? Theme.of(context).colorScheme.onErrorContainer
                  : Theme.of(context).colorScheme.onTertiaryContainer,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auto-Complete Warning',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isUrgent
                          ? Theme.of(context).colorScheme.onErrorContainer
                          : Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    daysLeft <= 0
                        ? 'This transaction will auto-complete today if no dispute is opened.'
                        : 'This transaction will auto-complete in $daysLeft day${daysLeft == 1 ? '' : 's'} if no action is taken.',
                    style: TextStyle(
                      color: isUrgent
                          ? Theme.of(context).colorScheme.onErrorContainer
                          : Theme.of(context).colorScheme.onTertiaryContainer,
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

  Widget _buildDisputeCard() {
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
                  Icons.report_problem,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                const SizedBox(width: 12),
                Text(
                  'Dispute Open',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Reason: ${_dispute!.reason}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Opened: ${_formatDateTime(_dispute!.createdAt)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
                fontSize: 12,
              ),
            ),
            if (_dispute!.moderatorId != null) ...[
              const SizedBox(height: 4),
              Text(
                'A moderator is reviewing this dispute.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final status = _transaction!.status;
    final actions = <Widget>[];

    // Seller: Mark as shipped
    if (_isSeller && status == TransactionStatus.open) {
      actions.add(
        FilledButton.icon(
          onPressed: _isActionLoading ? null : _markAsShipped,
          icon: const Icon(Icons.local_shipping),
          label: const Text('Mark as Shipped'),
        ),
      );
    }

    // Buyer: Mark as received
    if (_isBuyer && status == TransactionStatus.shipped) {
      actions.add(
        FilledButton.icon(
          onPressed: _isActionLoading ? null : _markAsReceived,
          icon: const Icon(Icons.check_circle),
          label: const Text('Mark as Received'),
        ),
      );
    }

    // Both: Cancel (only when open)
    if (status == TransactionStatus.open) {
      actions.add(
        OutlinedButton.icon(
          onPressed: _isActionLoading ? null : _cancelTransaction,
          icon: const Icon(Icons.cancel),
          label: const Text('Cancel'),
        ),
      );
    }

    // Buyer: Open dispute (only when shipped)
    if (_isBuyer && status == TransactionStatus.shipped) {
      actions.add(
        OutlinedButton.icon(
          onPressed: _isActionLoading ? null : _openDispute,
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          icon: const Icon(Icons.report_problem),
          label: const Text('Open Dispute'),
        ),
      );
    }

    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            if (_isActionLoading)
              const Center(child: CircularProgressIndicator())
            else
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: actions,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _markAsShipped() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as Shipped'),
        content: const Text(
          'Confirm that you have shipped the item. The buyer will have 14 days to confirm receipt or open a dispute.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isActionLoading = true);

    try {
      await client.transaction.markAsShipped(widget.transactionId);
      widget.onStatusChanged?.call();
      await _loadData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction marked as shipped')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isActionLoading = false);
      }
    }
  }

  Future<void> _markAsReceived() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as Received'),
        content: const Text(
          'Confirm that you have received the item. This will complete the transaction.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isActionLoading = true);

    try {
      await client.transaction.markAsReceived(widget.transactionId);
      widget.onStatusChanged?.call();
      await _loadData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction completed')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isActionLoading = false);
      }
    }
  }

  Future<void> _cancelTransaction() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Transaction'),
        content: const Text(
          'Are you sure you want to cancel this transaction? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Cancel Transaction'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isActionLoading = true);

    try {
      await client.transaction.cancel(widget.transactionId);
      widget.onStatusChanged?.call();
      await _loadData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction cancelled')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isActionLoading = false);
      }
    }
  }

  Future<void> _openDispute() async {
    final reasonController = TextEditingController();

    final result = await showDialog<String?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Open Dispute'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please describe the issue with this transaction. A moderator will review your dispute.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason',
                hintText: 'Describe the problem...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              maxLength: 500,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a reason')),
                );
                return;
              }
              Navigator.pop(context, reasonController.text.trim());
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Open Dispute'),
          ),
        ],
      ),
    );

    if (result == null) return;

    setState(() => _isActionLoading = true);

    try {
      await client.transaction.openDispute(
        widget.transactionId,
        reason: result,
      );
      widget.onStatusChanged?.call();
      await _loadData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dispute opened')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isActionLoading = false);
      }
    }
  }

  Widget _buildDetailsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Transaction ID', '#${_transaction!.id}'),
            _buildDetailRow('Quantity', '${_transaction!.quantity}'),
            _buildDetailRow(
                'Total Price', _formatPrice(_transaction!.totalPriceCents)),
            _buildDetailRow(
              'Payment Method',
              _transaction!.paymentMethod == PaymentMethod.paypal
                  ? 'PayPal'
                  : 'Bitcoin',
            ),
            _buildDetailRow('Created', _formatDateTime(_transaction!.createdAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildPartiesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Parties',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildPartyTile(
              label: 'Buyer',
              username: _buyerUsername ?? 'Unknown',
              userId: _transaction!.buyerId,
              isCurrentUser: _isBuyer,
            ),
            const SizedBox(height: 8),
            _buildPartyTile(
              label: 'Seller',
              username: _sellerUsername ?? 'Unknown',
              userId: _transaction!.sellerId,
              isCurrentUser: _isSeller,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartyTile({
    required String label,
    required String username,
    required int userId,
    required bool isCurrentUser,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(userId: userId),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                username.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
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
                        username,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (isCurrentUser) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'You',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListingCard() {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ListingDetailScreen(listingId: _listing!.id!),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.inventory_2,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _listing!.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'View listing details',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
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
  }

  Widget _buildBuyerNoteCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.note, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Buyer Note',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(_transaction!.buyerNote!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  _StatusInfo _getStatusInfo(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.open:
        return _StatusInfo(
          label: 'Open',
          description: 'Waiting for seller to ship the item',
          icon: Icons.hourglass_empty,
          color: Colors.orange,
        );
      case TransactionStatus.shipped:
        return _StatusInfo(
          label: 'Shipped',
          description: 'Item has been shipped, waiting for delivery',
          icon: Icons.local_shipping,
          color: Colors.blue,
        );
      case TransactionStatus.received:
        return _StatusInfo(
          label: 'Received',
          description: 'Buyer has received the item',
          icon: Icons.inbox,
          color: Colors.teal,
        );
      case TransactionStatus.completed:
        return _StatusInfo(
          label: 'Completed',
          description: 'Transaction successfully completed',
          icon: Icons.check_circle,
          color: Colors.green,
        );
      case TransactionStatus.disputed:
        return _StatusInfo(
          label: 'Disputed',
          description: 'A dispute has been opened',
          icon: Icons.report_problem,
          color: Colors.red,
        );
      case TransactionStatus.cancelled:
        return _StatusInfo(
          label: 'Cancelled',
          description: 'Transaction was cancelled',
          icon: Icons.cancel,
          color: Colors.grey,
        );
    }
  }

  String _formatPrice(int cents) {
    return '\$${(cents / 100).toStringAsFixed(2)}';
  }

  String _formatDateTime(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _StatusInfo {
  final String label;
  final String description;
  final IconData icon;
  final Color color;

  _StatusInfo({
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _TimelineStep {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isCancelled;
  final IconData icon;

  _TimelineStep({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    this.isCancelled = false,
    required this.icon,
  });
}
