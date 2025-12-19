import 'package:flutter/material.dart';

/// Dialog for entering a ban reason
class BanUserDialog extends StatefulWidget {
  const BanUserDialog({super.key});

  @override
  State<BanUserDialog> createState() => _BanUserDialogState();
}

class _BanUserDialogState extends State<BanUserDialog> {
  final _reasonController = TextEditingController();
  String? _selectedPreset;

  final List<String> _presetReasons = [
    'Spam',
    'Betrug/Scam',
    'Unangemessenes Verhalten',
    'Verstoß gegen Nutzungsbedingungen',
    'Mehrfach-Accounts',
    'Belästigung anderer Nutzer',
    'Illegale Aktivitäten',
  ];

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
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte geben Sie einen Grund ein')),
      );
      return;
    }

    Navigator.pop(context, reason);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Benutzer sperren'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bitte geben Sie einen Grund für die Sperre an:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Vordefinierte Gründe:',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _presetReasons.map((reason) {
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
              decoration: const InputDecoration(
                labelText: 'Grund (erforderlich)',
                hintText: 'Beschreiben Sie den Grund für die Sperre...',
                border: OutlineInputBorder(),
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
                      'Achtung: Beim Sperren werden alle aktiven Angebote des Benutzers deaktiviert und offene Transaktionen abgebrochen.',
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
          child: const Text('Abbrechen'),
        ),
        FilledButton(
          onPressed: _submit,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Sperren'),
        ),
      ],
    );
  }
}
