import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Utility class for localized date and time formatting
class DateFormatter {
  /// Format a date using the user's locale
  ///
  /// Example formats by locale:
  /// - de_DE: 10.01.2026
  /// - en_US: 1/10/2026
  /// - fr_FR: 10/01/2026
  /// - es_ES: 10/1/2026
  static String formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context);
    return DateFormat.yMd(locale.toString()).format(date);
  }

  /// Format a date with time using the user's locale
  ///
  /// Example formats by locale:
  /// - de_DE: 10.01.2026 14:30
  /// - en_US: 1/10/2026 2:30 PM
  /// - fr_FR: 10/01/2026 14:30
  /// - es_ES: 10/1/2026 14:30
  static String formatDateTime(BuildContext context, DateTime dateTime) {
    final locale = Localizations.localeOf(context);
    final dateFormat = DateFormat.yMd(locale.toString());
    final timeFormat = DateFormat.Hm(locale.toString());
    return '${dateFormat.format(dateTime)} ${timeFormat.format(dateTime)}';
  }

  /// Format only the time using the user's locale
  ///
  /// Example formats by locale:
  /// - de_DE: 14:30
  /// - en_US: 2:30 PM
  /// - fr_FR: 14:30
  /// - es_ES: 14:30
  static String formatTime(BuildContext context, DateTime time) {
    final locale = Localizations.localeOf(context);
    return DateFormat.Hm(locale.toString()).format(time);
  }

  /// Format a date in a more readable format with month name
  ///
  /// Example formats by locale:
  /// - de_DE: 10. Januar 2026
  /// - en_US: January 10, 2026
  /// - fr_FR: 10 janvier 2026
  /// - es_ES: 10 de enero de 2026
  static String formatDateLong(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context);
    return DateFormat.yMMMMd(locale.toString()).format(date);
  }

  /// Format a date in a short format with abbreviated month
  ///
  /// Example formats by locale:
  /// - de_DE: 10. Jan. 2026
  /// - en_US: Jan 10, 2026
  /// - fr_FR: 10 janv. 2026
  /// - es_ES: 10 ene 2026
  static String formatDateMedium(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context);
    return DateFormat.yMMMd(locale.toString()).format(date);
  }

  /// Format a relative time (e.g., "2 hours ago", "in 3 days")
  /// Falls back to absolute date if more than 7 days
  static String formatRelativeTime(BuildContext context, DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.isNegative) {
      // Future date
      final futureDiff = dateTime.difference(now);
      if (futureDiff.inMinutes < 60) {
        return 'in ${futureDiff.inMinutes} min';
      } else if (futureDiff.inHours < 24) {
        return 'in ${futureDiff.inHours} h';
      } else if (futureDiff.inDays < 7) {
        return 'in ${futureDiff.inDays} days';
      }
    } else {
      // Past date
      if (difference.inMinutes < 1) {
        return 'just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} min ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      }
    }

    // More than 7 days, show absolute date
    return formatDate(context, dateTime);
  }
}
