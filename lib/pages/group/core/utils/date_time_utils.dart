import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  static String toDisplay(DateTime dt) {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(dt);
  }

  static String toApi(DateTime dt) {
    final utc = dt.subtract(const Duration(hours: 3));
    return DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(utc);
  }

  static DateTime? fromApi(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      return DateFormat('dd/MM/yyyy HH:mm').parse(raw);
    } catch (_) {
      return null;
    }
  }
}
