import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/app_list_card.dart';
import 'package:sorteador_amigo_secreto/core/util/get_initials.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final String groupToken;
  final String groupCode;
  final bool isRaffled;
  final int index;
  final Color color;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.groupToken,
    required this.groupCode,
    required this.index,
    required this.isRaffled,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppListCard(
      title: groupName,
      subtitle: isRaffled ? l10n.badgeRaffled : l10n.badgePending,
      color: color,
      initials: GetInitials.initials(groupName),
      borderRadius: 16,
      backgroundColor: SecretSantaColors.neutral50,
      border: Border.all(
        color: SecretSantaColors.neutral200.withAlpha(150),
      ),
      avatarSize: 52,
      trailing: Icon(Icons.chevron_right, color: color),
    );
  }
}
