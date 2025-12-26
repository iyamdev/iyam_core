import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  // ==============================
  // BASIC FORMATTERS
  // ==============================

  static String format(
    DateTime date, {
    String pattern = 'dd/MM/yyyy',
    String locale = 'id_ID',
  }) {
    return DateFormat(pattern, locale).format(date);
  }

  static String dateOnly(
    DateTime date, {
    String locale = 'id_ID',
  }) {
    return DateFormat('dd MMM yyyy', locale).format(date);
  }

  static String dateTime(
    DateTime date, {
    String locale = 'id_ID',
  }) {
    return DateFormat(
      'dd MMM yyyy HH:mm',
      locale,
    ).format(date);
  }

  static String timeOnly(
    DateTime date, {
    String locale = 'id_ID',
  }) {
    return DateFormat('HH:mm', locale).format(date);
  }

  // ==============================
  // API & STORAGE
  // ==============================

  /// ISO 8601 → API standard
  static String toIso(DateTime date) {
    return date.toUtc().toIso8601String();
  }

  static DateTime fromIso(String value) {
    return DateTime.parse(value);
  }

  // ==============================
  // HUMAN READABLE
  // ==============================

  static String relative(
    DateTime date, {
    DateTime? reference,
    String locale = 'id_ID',
  }) {
    final now = reference ?? DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) {
      return 'baru saja';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} menit lalu';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} jam lalu';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} hari lalu';
    }

    return dateOnly(date, locale: locale);
  }

  // ==============================
  // SAFE PARSER
  // ==============================

  static DateTime? tryParse(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }
}
