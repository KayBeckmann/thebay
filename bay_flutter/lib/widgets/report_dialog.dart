import 'package:flutter/material.dart';
import 'package:bay_client/bay_client.dart';

import '../l10n/app_localizations.dart';
import '../main.dart' show client;

/// Dialog for reporting a listing or user
class ReportDialog extends StatefulWidget {
  final ReportTargetType targetType;
  final int targetId;
  final String targetName; // For display purposes

  const ReportDialog({
    super.key,
    required this.targetType,
    required this.targetId,
    required this.targetName,
  });

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  ReportReason? _selectedReason;
  final _detailsController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  String _getReasonLabel(ReportReason reason, AppLocalizations l10n) {
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

  Future<void> _submitReport() async {
    final l10n = AppLocalizations.of(context)!;

    if (_selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reportSelectReason)),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final details = _detailsController.text.trim();

      if (widget.targetType == ReportTargetType.listing) {
        await client.report.createListingReport(
          widget.targetId,
          _selectedReason!,
          details.isEmpty ? null : details,
        );
      } else {
        await client.report.createUserReport(
          widget.targetId,
          _selectedReason!,
          details.isEmpty ? null : details,
        );
      }

      if (mounted) {
        Navigator.pop(context, true); // Return true to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.reportSubmittedSuccessfully,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);

        final l10n = AppLocalizations.of(context)!;
        String errorMessage = l10n.reportSubmitError;
        if (e.toString().contains('already reported')) {
          errorMessage = l10n.reportAlreadyReported;
        } else if (e.toString().contains('not found')) {
          errorMessage = l10n.reportTargetNotFound;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final targetTypeLabel = widget.targetType == ReportTargetType.listing
        ? l10n.reportTargetListing
        : l10n.reportTargetUser;

    return AlertDialog(
      title: Text(l10n.reportTitle(targetTypeLabel)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.reportYouAreReporting(widget.targetName),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.reportReasonLabel,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ...ReportReason.values.map((reason) {
              return RadioListTile<ReportReason>(
                title: Text(_getReasonLabel(reason, l10n)),
                value: reason,
                groupValue: _selectedReason,
                onChanged: _isSubmitting
                    ? null
                    : (value) => setState(() => _selectedReason = value),
                dense: true,
                contentPadding: EdgeInsets.zero,
              );
            }),
            const SizedBox(height: 16),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(
                labelText: l10n.reportDetailsOptional,
                hintText: l10n.reportDetailsHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              maxLength: 500,
              enabled: !_isSubmitting,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _isSubmitting ? null : _submitReport,
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.report),
        ),
      ],
    );
  }
}
