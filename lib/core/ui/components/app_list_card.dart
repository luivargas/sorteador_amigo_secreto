import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class AppListCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color color;
  final String initials;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double borderRadius;
  final Color backgroundColor;
  final Border? border;
  final double avatarSize;
  final IconData? icon;

  const AppListCard({
    super.key,
    required this.title,
    required this.color,
    required this.initials,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.borderRadius = 24,
    this.backgroundColor = SecretSantaColors.neutral50,
    this.border,
    this.avatarSize = 56,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: SecretSantaColors.accent,
      splashColor: color.withValues(alpha: 0.2),
      highlightColor: color.withValues(alpha: 0.1),
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Ink(
        padding: const EdgeInsets.all(SecretSantaSpacing.md),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          boxShadow: SecretSantaShadows.small,
        ),
        child: Row(
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(avatarSize * 0.27),
              ),
              child: Center(
                child: icon != null
                    ? Icon(
                        icon,
                        color: SecretSantaColors.neutral50,
                        size: avatarSize * 0.5,
                      )
                    : Text(
                        initials,
                        style: TextStyle(
                          color: SecretSantaColors.neutral50,
                          fontWeight: FontWeight.bold,
                          fontSize: avatarSize * 0.36,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(fontSize: 13, color: color),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
          ],
        ),
      ),
    );
  }
}
