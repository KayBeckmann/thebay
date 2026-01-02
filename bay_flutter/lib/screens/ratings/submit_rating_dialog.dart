import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart' show client;

/// Dialog zum Abgeben einer Bewertung nach einer Transaktion.
Future<Rating?> showSubmitRatingDialog(
  BuildContext context, {
  required int transactionId,
  required String partnerUsername,
  required bool isBuyer,
}) async {
  return showDialog<Rating>(
    context: context,
    builder: (context) => _SubmitRatingDialog(
      transactionId: transactionId,
      partnerUsername: partnerUsername,
      isBuyer: isBuyer,
    ),
  );
}

class _SubmitRatingDialog extends StatefulWidget {
  final int transactionId;
  final String partnerUsername;
  final bool isBuyer;

  const _SubmitRatingDialog({
    required this.transactionId,
    required this.partnerUsername,
    required this.isBuyer,
  });

  @override
  State<_SubmitRatingDialog> createState() => _SubmitRatingDialogState();
}

class _SubmitRatingDialogState extends State<_SubmitRatingDialog> {
  RatingValue? _selectedRating;
  final _commentController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.rateTransaction),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Partner Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      widget.partnerUsername.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.partnerUsername,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.isBuyer ? l10n.seller : l10n.buyer,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Rating Selection
            Text(
              l10n.howWasYourExperience,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Rating Buttons
            Row(
              children: [
                Expanded(
                  child: _RatingButton(
                    rating: RatingValue.positive,
                    icon: Icons.thumb_up,
                    label: l10n.ratingGood,
                    color: Colors.green,
                    isSelected: _selectedRating == RatingValue.positive,
                    onTap: () =>
                        setState(() => _selectedRating = RatingValue.positive),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _RatingButton(
                    rating: RatingValue.neutral,
                    icon: Icons.thumbs_up_down,
                    label: l10n.ratingNeutral,
                    color: Colors.orange,
                    isSelected: _selectedRating == RatingValue.neutral,
                    onTap: () =>
                        setState(() => _selectedRating = RatingValue.neutral),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _RatingButton(
                    rating: RatingValue.negative,
                    icon: Icons.thumb_down,
                    label: l10n.ratingBad,
                    color: Colors.red,
                    isSelected: _selectedRating == RatingValue.negative,
                    onTap: () =>
                        setState(() => _selectedRating = RatingValue.negative),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Comment Field
            Text(
              l10n.commentOptional,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: l10n.shareYourExperience,
              ),
              maxLines: 3,
              maxLength: 500,
            ),

            // Error
            if (_error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed:
              _isLoading || _selectedRating == null ? null : _submitRating,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.submitRating),
        ),
      ],
    );
  }

  Future<void> _submitRating() async {
    if (_selectedRating == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final rating = await client.rating.submitRating(
        transactionId: widget.transactionId,
        rating: _selectedRating!,
        comment: _commentController.text.trim().isEmpty
            ? null
            : _commentController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context, rating);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.ratingSubmittedSuccessfully,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString().replaceAll('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }
}

class _RatingButton extends StatelessWidget {
  final RatingValue rating;
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _RatingButton({
    required this.rating,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? color.withAlpha(30) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : Theme.of(context).colorScheme.outline,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: isSelected
                    ? color
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? color
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
