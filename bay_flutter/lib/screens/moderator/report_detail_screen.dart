import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart' show client;
import '../listings/listing_detail_screen.dart';
import '../user_profile_screen.dart';

/// Detail screen for a single report with moderator actions
class ReportDetailScreen extends StatefulWidget {
  final int reportId;

  const ReportDetailScreen({super.key, required this.reportId});

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  Report? _report;
  bool _isLoading = true;
  String? _error;
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final report = await client.report.getById(widget.reportId);
      if (mounted) {
        setState(() {
          _report = report;
          _noteController.text = report?.moderatorNotes ?? '';
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

  Future<void> _assignToMe() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await client.report.assignToMe(widget.reportId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.reportAssignedToYou),
            backgroundColor: Colors.green,
          ),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorLoading(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _updateStatus(ReportStatus newStatus) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await client.report.updateStatus(widget.reportId, newStatus);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.statusUpdated),
            backgroundColor: Colors.green,
          ),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorLoading(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveNote() async {
    final l10n = AppLocalizations.of(context)!;
    final note = _noteController.text.trim();
    if (note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.noteCannotBeEmpty)),
      );
      return;
    }

    try {
      await client.report.addModeratorNote(widget.reportId, note);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.noteSaved),
            backgroundColor: Colors.green,
          ),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorLoading(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deactivateListing() async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deactivateListing),
        content: Text(l10n.deactivateListingConfirm),
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
            child: Text(l10n.deactivate),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await client.report.deactivateReportedListing(widget.reportId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.listingDeactivated),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Return to previous screen
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorLoading(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reportId(widget.reportId)),
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
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    if (_report == null) {
      return Center(child: Text(l10n.reportNotFound));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(),
          const SizedBox(height: 16),
          _buildReportInfo(),
          const SizedBox(height: 16),
          _buildTargetCard(),
          const SizedBox(height: 16),
          _buildModeratorNotes(),
          const SizedBox(height: 16),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = _getStatusColor(_report!.status);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _getStatusText(_report!.status),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_report!.assignedModeratorId != null)
              Text(
                l10n.assignedToModerator(_report!.assignedModeratorId!),
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else
              Text(
                l10n.notYetAssigned,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportInfo() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.reportDetails,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.flag, l10n.reason, _getReasonText(_report!.reason)),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.access_time,
              l10n.reportedOn,
              _formatFullDate(_report!.createdAt),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.person,
              l10n.reportedBy,
              l10n.reporterUser(_report!.reporterId),
            ),
            if (_report!.details != null && _report!.details!.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                l10n.details,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                _report!.details!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTargetCard() {
    final l10n = AppLocalizations.of(context)!;
    final isListing = _report!.targetType == ReportTargetType.listing;

    return Card(
      child: InkWell(
        onTap: () {
          if (isListing) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ListingDetailScreen(listingId: _report!.targetId),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    UserProfileScreen(userId: _report!.targetId),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                isListing ? Icons.inventory_2 : Icons.person,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isListing ? l10n.reportedListing : l10n.reportedUserProfile,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isListing ? l10n.listingId(_report!.targetId) : l10n.userId(_report!.targetId),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeratorNotes() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.moderatorNotes,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                hintText: l10n.addInternalNotes,
                border: const OutlineInputBorder(),
              ),
              maxLines: 4,
              maxLength: 1000,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: _saveNote,
                icon: const Icon(Icons.save),
                label: Text(l10n.save),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    final l10n = AppLocalizations.of(context)!;
    final isOpen = _report!.status == ReportStatus.open;
    final isReviewing = _report!.status == ReportStatus.reviewing;
    final isListing = _report!.targetType == ReportTargetType.listing;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.actions,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            if (isOpen) ...[
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _assignToMe,
                  icon: const Icon(Icons.person_add),
                  label: Text(l10n.assignToMe),
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (isOpen || isReviewing) ...[
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _updateStatus(ReportStatus.resolved),
                  icon: const Icon(Icons.check_circle),
                  label: Text(l10n.markAsResolved),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _updateStatus(ReportStatus.dismissed),
                  icon: const Icon(Icons.cancel),
                  label: Text(l10n.dismiss),
                ),
              ),
              if (isListing) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _deactivateListing,
                    icon: const Icon(Icons.block),
                    label: Text(l10n.deactivateListing),
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(ReportStatus status) {
    switch (status) {
      case ReportStatus.open:
        return Colors.orange;
      case ReportStatus.reviewing:
        return Colors.blue;
      case ReportStatus.resolved:
        return Colors.green;
      case ReportStatus.dismissed:
        return Colors.grey;
    }
  }

  String _getStatusText(ReportStatus status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case ReportStatus.open:
        return l10n.reportStatusOpen;
      case ReportStatus.reviewing:
        return l10n.reportStatusReviewing;
      case ReportStatus.resolved:
        return l10n.reportStatusResolved;
      case ReportStatus.dismissed:
        return l10n.reportStatusDismissed;
    }
  }

  String _getReasonText(ReportReason reason) {
    final l10n = AppLocalizations.of(context)!;
    switch (reason) {
      case ReportReason.spam:
        return l10n.reportReasonSpam;
      case ReportReason.inappropriate:
        return l10n.reportReasonInappropriate;
      case ReportReason.scam:
        return l10n.reportReasonScam;
      case ReportReason.fraud:
        return l10n.reportReasonFraud;
      case ReportReason.harassment:
        return l10n.reportReasonHarassment;
      case ReportReason.other:
        return l10n.reportReasonOther;
    }
  }

  String _formatFullDate(DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return l10n.fullDateTimeFormat(day, month, year, hour, minute);
  }
}
