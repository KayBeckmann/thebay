import 'package:flutter/material.dart';
import 'package:bay_client/bay_client.dart';

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

  String _getReasonLabel(ReportReason reason) {
    switch (reason) {
      case ReportReason.spam:
        return 'Spam';
      case ReportReason.inappropriate:
        return 'Unangemessener Inhalt';
      case ReportReason.scam:
        return 'Betrug/Scam';
      case ReportReason.fraud:
        return 'Betrügerisches Angebot';
      case ReportReason.harassment:
        return 'Belästigung';
      case ReportReason.other:
        return 'Sonstiges';
    }
  }

  Future<void> _submitReport() async {
    if (_selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte wähle einen Grund aus')),
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
          const SnackBar(
            content: Text('Meldung erfolgreich eingereicht'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);

        String errorMessage = 'Fehler beim Einreichen der Meldung';
        if (e.toString().contains('already reported')) {
          errorMessage = 'Du hast dies bereits gemeldet';
        } else if (e.toString().contains('not found')) {
          errorMessage = 'Eintrag nicht gefunden';
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
    final targetTypeLabel = widget.targetType == ReportTargetType.listing
        ? 'Angebot'
        : 'Benutzer';

    return AlertDialog(
      title: Text('$targetTypeLabel melden'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Du meldest: "${widget.targetName}"',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Grund der Meldung:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ...ReportReason.values.map((reason) {
              return RadioListTile<ReportReason>(
                title: Text(_getReasonLabel(reason)),
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
              decoration: const InputDecoration(
                labelText: 'Zusätzliche Details (optional)',
                hintText: 'Beschreibe das Problem...',
                border: OutlineInputBorder(),
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
          child: const Text('Abbrechen'),
        ),
        FilledButton(
          onPressed: _isSubmitting ? null : _submitReport,
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Melden'),
        ),
      ],
    );
  }
}
