import 'package:flutter/material.dart';

class GetInitials {
  static String initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  static Text initialsWhithColor(String name, Color color) {
    final text = name.trim();
    final avatar = text.split(' ').where((p) => p.isNotEmpty).toList();
    final first = avatar.first[0].toUpperCase();
    final last = avatar.length > 1 ? avatar.last[0].toUpperCase() : '';
    return Text(
      '$first$last',
      style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 25),
    );
  }
}
