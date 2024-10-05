import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _displayFormat = DateFormat('dd MMMM yyyy');
  static final DateFormat _apiFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _fullFormat = DateFormat('dd MMMM yyyy HH:mm');

  // Convert DateTime to display format (e.g., "25 Maret 2024")
  static String toDisplayDate(DateTime date) {
    return _displayFormat.format(date);
  }

  // Convert DateTime to API format (e.g., "2024-03-25")
  static String toApiDate(DateTime date) {
    return _apiFormat.format(date);
  }

  // Convert string from API to DateTime
  static DateTime? fromApiDate(String date) {
    try {
      return _apiFormat.parse(date);
    } catch (e) {
      return null;
    }
  }

  // Get time only (e.g., "14:30")
  static String getTimeOnly(DateTime date) {
    return _timeFormat.format(date);
  }

  // Get full date time (e.g., "25 Maret 2024 14:30")
  static String getFullDateTime(DateTime date) {
    return _fullFormat.format(date);
  }

  // Convert string to DateTime for form inputs
  static DateTime? parseInputDate(String date) {
    try {
      return _displayFormat.parse(date);
    } catch (e) {
      return null;
    }
  }

  // Get readable difference (e.g., "2 hari yang lalu")
  static String getReadableDifference(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} tahun yang lalu';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} bulan yang lalu';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }
}