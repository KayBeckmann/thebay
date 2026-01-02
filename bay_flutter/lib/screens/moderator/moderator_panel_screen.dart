import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart' show client;
import 'report_detail_screen.dart';

/// Moderator panel for managing reports
class ModeratorPanelScreen extends StatefulWidget {
  const ModeratorPanelScreen({super.key});

  @override
  State<ModeratorPanelScreen> createState() => _ModeratorPanelScreenState();
}

class _ModeratorPanelScreenState extends State<ModeratorPanelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Report> _reports = [];
  bool _isLoading = true;
  String? _error;
  int _openCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Load open count
      final count = await client.report.getOpenCount();

      // Load reports based on tab
      List<Report> reports;
      switch (_tabController.index) {
        case 0: // All
          reports = await client.report.getAllReports();
          break;
        case 1: // Listings
          reports = await client.report.getAllReports(
            targetType: ReportTargetType.listing,
          );
          break;
        case 2: // Users
          reports = await client.report.getAllReports(
            targetType: ReportTargetType.user,
          );
          break;
        default:
          reports = [];
      }

      if (mounted) {
        setState(() {
          _reports = reports;
          _openCount = count;
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(l10n.moderatorPanelScreen),
            if (_openCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  l10n.openReportsCount(_openCount),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                ),
              ),
            ],
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.allReports, icon: const Icon(Icons.list)),
            Tab(text: l10n.listingReports, icon: const Icon(Icons.inventory_2)),
            Tab(text: l10n.userReports, icon: const Icon(Icons.person)),
          ],
        ),
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

    if (_reports.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noReports,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noReportsDescription,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
        itemCount: _reports.length,
        itemBuilder: (context, index) {
          final report = _reports[index];
          return _buildReportCard(report);
        },
      ),
    );
  }

  Widget _buildReportCard(Report report) {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = _getStatusColor(report.status);
    final reasonText = _getReasonText(report.reason);
    final targetTypeText = report.targetType == ReportTargetType.listing
        ? l10n.listing
        : l10n.user;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportDetailScreen(reportId: report.id!),
            ),
          );
          // Refresh if changes were made
          if (result == true) {
            _loadData();
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Status badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(report.status),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Target type
                  Chip(
                    label: Text(targetTypeText),
                    avatar: Icon(
                      report.targetType == ReportTargetType.listing
                          ? Icons.inventory_2
                          : Icons.person,
                      size: 18,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                  const Spacer(),
                  // ID
                  Text(
                    '#${report.id}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Reason
              Row(
                children: [
                  Icon(
                    Icons.flag,
                    size: 16,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    reasonText,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              if (report.details != null && report.details!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  report.details!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              // Footer
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(report.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  if (report.assignedModeratorId != null) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.person_outline,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.assigned,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
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

  String _formatDate(DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return l10n.justNow;
    } else if (difference.inHours < 1) {
      return l10n.minutesAgo(difference.inMinutes);
    } else if (difference.inDays < 1) {
      return l10n.hoursAgo(difference.inHours);
    } else if (difference.inDays < 7) {
      return l10n.daysAgo(difference.inDays);
    } else {
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      return '$day.$month.${date.year}';
    }
  }
}
