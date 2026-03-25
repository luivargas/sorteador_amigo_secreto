import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/stat_card.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/list_participants_card.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        spacing: 20,
        children: [
          StatCard(
            value: AppLocalizations.of(context)!.eventDate,
            label: '$eventDate - $eventTime',
            icon: Icons.calendar_month,
          ),
          StatCard(
            value: AppLocalizations.of(context)!.suggestedValue,
            label: 'R\$ $minGiftValue - R\$ $maxGiftValue',
            icon: Icons.monetization_on,
          ),
          StatCard(
            value: AppLocalizations.of(context)!.location,
            label: eventLocation,
            icon: Icons.location_on,
          ),
          StatCard(
            value: AppLocalizations.of(context)!.description,
            label: groupDescription,
            icon: Icons.description,
          ),
          Row(
            children: [
              Expanded(
                child: ListParticipantsCard(
                  type: type,
                  participantsList: participantsList,
                  groupToken: groupToken,
                  groupCode: groupCode,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
