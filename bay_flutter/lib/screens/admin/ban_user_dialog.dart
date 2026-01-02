import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Dialog for entering a ban reason
class BanUserDialog extends StatefulWidget {
  const BanUserDialog({super.key});

  @override
  State<BanUserDialog> createState() => _BanUserDialogState();
}

class _BanUserDialogState extends State<BanUserDialog> {
  final _reasonController = TextEditingController();
  String? _selectedPreset;

  List<String> _getPresetReasons(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.banReasonSpam,
      l10n.banReasonFraud,
      l10n.banReasonInappropriate,
      l10n.banReasonTosViolation,
      l10n.banReasonMultipleAccounts,
      l10n.banReasonHarassment,
      l10n.banReasonIllegal,
    ];
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _selectPreset(String? preset) {
    setState(() {
      _selectedPreset = preset;
      if (preset != null) {
        _reasonController.text = preset;
      }
    });
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.banReasonRequired)),
      );
      return;
    }

    Navigator.pop(context, reason);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final presetReasons = _getPresetReasons(context);

    return AlertDialog(
      title: Text(l10n.banUser),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.enterBanReason,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.presetReasons,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: presetReasons.map((reason) {
                final isSelected = _selectedPreset == reason;
                return FilterChip(
                  label: Text(reason),
                  selected: isSelected,
                  onSelected: (selected) {
                    _selectPreset(selected ? reason : null);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                labelText: l10n.reasonRequired,
                hintText: l10n.describeBanReason,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              maxLength: 500,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.banWarning,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _submit,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(l10n.banAction),
        ),
      ],
    );
  }
}
