import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class GetInitials {
  static Widget initials(String name, {TextStyle? style, Color? color}) {
    final text = name.trim();
    final avatar = text.split(' ').where((p) => p.isNotEmpty).toList();
    final first = avatar.first[0].toUpperCase();
    final last = avatar.length > 1 ? avatar.last[0].toUpperCase() : '';
    return Center(
      child: Text(
        '$first$last'.toUpperCase(),
        style:
            style ??
            TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: color ?? SecretSantaColors.neutral50,
            ),
      ),
    );
  }
}
