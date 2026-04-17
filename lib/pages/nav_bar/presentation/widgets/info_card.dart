import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.icon,
    required this.iconBackgroundColor,
    this.textColor = SecretSantaColors.neutral50,
    this.padding = const EdgeInsets.all(SecretSantaSpacing.md),
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            right: -32,
            bottom: -32,
            child: Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: SecretSantaSpacing.sm,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: textColor,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withValues(alpha: 0.75),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // ícone
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: SecretSantaShadows.small
                ),
                child: Icon(
                  icon,
                  color: textColor,
                  size: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}