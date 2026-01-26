import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/components/stat_card.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/list_participants_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class ViewGroupCard extends StatelessWidget {
  final int groupId;
  final String eventLocation;
  final String minGiftValue;
  final String maxGiftValue;
  final String eventDate;
  final String eventTime;
  final String groupDescription;
  final int participants;
  final List<ShowParticipantModel> participantsList;
  final String groupAccessKey;
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
    required this.groupId,
    required this.groupAccessKey,
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
            value: eventDate,
            label: eventTime,
            icon: Icons.calendar_month,
          ),
          Column(
            children: [
              StatCard(
                value: 'R\$ $minGiftValue - R\$ $maxGiftValue',
                label: 'Valor sugerido',
                icon: Icons.monetization_on,
              ),
            ],
          ),
          Column(
            children: [
              StatCard(
                value: eventLocation,
                label: 'Local',
                icon: Icons.location_on,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: SecretSantaColors.neutral50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: MyColors.sorteadorOrange,
                      width: 1,
                    ),
                    boxShadow: SecretSantaShadows.medium,
                  ),
                  child: Column(
                    spacing: 20,
                    children: [
                      Row(
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.description,
                            color: MyColors.sorteadorPurpple,
                          ),
                          Text(
                            'Descrição',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(groupDescription),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListParticipantsCard(
                  type: type,
                  participantsList: participantsList,
                  groupId: groupId, groupAccessKey: groupAccessKey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
