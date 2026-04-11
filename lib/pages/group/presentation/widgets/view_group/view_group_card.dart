import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/stat_card.dart';
import 'package:sorteador_amigo_secreto/pages/group/core/utils/gift_utils.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/group_participants_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class ViewGroupCard extends StatelessWidget {
  final String eventLocation;
  final String minGiftValue;
  final String maxGiftValue;
  final String eventDate;
  final String eventTime;
  final String groupDescription;
  final int participants;
  final List<ShowParticipantModel> participantsList;
  final String groupToken;
  final String groupCode;
  final BadgeType type;

  const ViewGroupCard({
    super.key,
    required this.type,
    required this.participants,
    required this.eventLocation,
    required this.minGiftValue,
    required this.maxGiftValue,
    required this.eventDate,
    required this.eventTime,
    required this.groupDescription,
    required this.participantsList,
    required this.groupToken,
    required this.groupCode,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      spacing: 12,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Expanded(
              child: StatCard(
                value: l10n.eventDate,
                label: eventDate,
                subLabel: eventTime,
                icon: Icons.calendar_today_outlined,
                iconColor: SecretSantaColors.accent,
                color: SecretSantaColors.neutral50,
              ),
            ),
            Expanded(
              child: StatCard(
                value: l10n.suggestedValue,
                label: GiftUtils.toDisplayFormat(minGiftValue),
                subLabel: GiftUtils.toDisplayFormat(maxGiftValue),
                icon: Icons.payments_outlined,
                iconColor: SecretSantaColors.accent,
                color: SecretSantaColors.neutral50,
              ),
            ),
          ],
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: SecretSantaColors.neutral50,
            border: Border.all(
              color: SecretSantaColors.neutral200.withValues(alpha: 0.8),
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: SecretSantaShadows.medium,
          ),
          child: Row(
            spacing: 16,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: SecretSantaColors.accent2.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.place_outlined,
                  color: SecretSantaColors.accent2,
                  size: 24,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      l10n.location,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: SecretSantaColors.neutral500,
                      ),
                    ),
                    Text(
                      eventLocation,
                      style: SecretSantaTextStyles.labelSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: SecretSantaColors.neutral50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: SecretSantaColors.neutral200.withValues(alpha: 0.8),
            ),
            boxShadow: SecretSantaShadows.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              Row(
                spacing: 6,
                children: [
                  Icon(
                    Icons.notes_outlined,
                    color: SecretSantaColors.accent,
                    size: 16,
                  ),
                  Text(
                    l10n.description,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: SecretSantaColors.accent,
                    ),
                  ),
                ],
              ),
              Text(
                groupDescription,
                style: SecretSantaTextStyles.body.copyWith(
                  color: SecretSantaColors.neutral700,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        GroupParticipantsCard(
          type: type,
          participantsList: participantsList,
          groupToken: groupToken,
          groupCode: groupCode,
        ),
      ],
    );
  }
}
