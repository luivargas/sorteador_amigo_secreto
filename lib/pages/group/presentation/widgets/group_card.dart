import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class GroupCard extends StatefulWidget {
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
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  Text _initials(Color color) {
    final text = widget.groupName.trim();
    final parts = text.split(' ').where((p) => p.isNotEmpty).toList();
    final first = parts.first[0].toUpperCase();
    final last = parts.length > 1 ? parts.last[0].toUpperCase() : '';
    return Text(
      '$first$last',
      style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 25),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: MyColors.neutral50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MyColors.neutral200.withAlpha(150)),
        boxShadow: SecretSantaShadows.small,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          spacing: 20,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(child: _initials(widget.color)),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.groupName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right, color: widget.color),
                    ],
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      Icon(Icons.circle, color: widget.color, size: 10),
                      Text( widget.isRaffled ? l10n!.badgeRaffled
                        : l10n!.badgePending,
                        style: TextStyle(color: widget.color),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
