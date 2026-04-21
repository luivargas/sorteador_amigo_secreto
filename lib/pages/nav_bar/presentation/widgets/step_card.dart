import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class StepCard extends StatelessWidget {
  final String step;
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isLast;
  const StepCard({
    super.key,
    required this.step,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        spacing: SecretSantaSpacing.lg,
        children: [
          Column(
            spacing: SecretSantaSpacing.sm,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: SecretSantaColors.neutral50, size: 28),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: SecretSantaColors.neutral500.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.stepLabel(step),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
