import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final VoidCallback? onDelete;
  final String? deleteTitle;
  final String? deleteMessage;
  final String? blockedMessage;

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
    this.onDelete,
    this.deleteTitle,
    this.deleteMessage,
    this.blockedMessage,
  });

  Future<void> _onLongPress(BuildContext context) async {
    if (blockedMessage != null) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Ação não permitida'),
          content: Text(blockedMessage!),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Entendi'),
            ),
          ],
        ),
      );
      return;
    }

    if (onDelete == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(deleteTitle ?? 'Excluir'),
        content: Text(deleteMessage ?? 'Deseja excluir este item?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancelar',style: TextStyle(color: SecretSantaColors.accent2)),
          ),
          TextButton(
            onPressed: () => context.pop( true),
            child: const Text('Excluir', style: TextStyle(color: SecretSantaColors.accent)),
          ),
        ],
      ),
    );

    if (confirmed == true) onDelete!();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: SecretSantaColors.accent,
      splashColor: color.withValues(alpha: 0.2),
      highlightColor: color.withValues(alpha: 0.1),
      onLongPress: (onDelete != null || blockedMessage != null)
          ? () => _onLongPress(context)
          : null,
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Ink(
        padding: const EdgeInsets.all(16),
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
                child: Text(
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
