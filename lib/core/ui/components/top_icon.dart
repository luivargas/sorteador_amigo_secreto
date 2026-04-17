import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class TopIcon extends StatelessWidget {
  final IconData icon;
  const TopIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SecretSantaSpacing.sm),
      decoration: BoxDecoration(
        color: SecretSantaColors.accent,
        borderRadius: BorderRadius.all(Radius.circular(SecretSantaRadius.lg)),
        boxShadow: SecretSantaShadows.small,
      ),
      child: Icon(icon, size: 50, color: SecretSantaColors.neutral50),
    );
  }
}
