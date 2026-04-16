import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart'
    hide AlertType;

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final String? subLabel;
  final IconData? icon;
  final Color iconColor;
  final Color color;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.subLabel,
    this.icon,
    required this.iconColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: SecretSantaColors.neutral200.withValues(alpha: 0.8),
        ),
        boxShadow: SecretSantaShadows.medium,
      ),
      child: Column(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: iconColor),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: iconColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            label,
            style: SecretSantaTextStyles.labelSmall.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          if (subLabel != null)
            Text(
              subLabel!,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
        ],
      ),
    );
  }
}
