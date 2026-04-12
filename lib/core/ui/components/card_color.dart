import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class CardColor {
  static final List<Color> _cardColors = [
    SecretSantaColors.accent,
    SecretSantaColors.accent2,
  ];

  static Color getColor(int index) => _cardColors[index % _cardColors.length];
}
