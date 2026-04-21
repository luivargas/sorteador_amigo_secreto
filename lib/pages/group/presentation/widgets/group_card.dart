import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/app_list_card.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final bool isRaffled;
  final int index;
  final Color color;
  final VoidCallback? onPress;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.index,
    required this.isRaffled,
    required this.color,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return AppListCard(
      onTap: onPress,
      title: groupName,
      subtitle: isRaffled ? i18n.badgeRaffled : i18n.badgePending,
      color: color,
      name: groupName,
      borderRadius: 16,
      backgroundColor: SecretSantaColors.neutral50,
      border: Border.all(color: SecretSantaColors.neutral200.withAlpha(150)),
      avatarSize: 52,
      trailing: Icon(Icons.chevron_right, color: color),
    );
  }
}
