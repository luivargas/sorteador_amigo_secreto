// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/create_parti_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/show_parti_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/participant_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class ListParticipantsCard extends StatelessWidget {
  final int groupId;
  final String groupToken;
  final String groupCode;
  final BadgeType type;
  final List<ShowParticipantModel> participantsList;
  const ListParticipantsCard({
    super.key,
    required this.participantsList,
    required this.groupId,
    required this.groupToken,
    required this.type, required this.groupCode,
  });

  @override
  Widget build(BuildContext context) {
    buildCollapsed1() {
      return Column(
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (_, _) => Container(),
            itemCount: min(participantsList.length, 6),
            itemBuilder: (context, index) {
              final f = participantsList[index];
              return InkWell(
                onTap: () {
                  context.pushNamed(
                    'view_parti',
                    extra: ShowParticipantArgs(
                      userId: f.id,
                      groupToken: groupToken,
                    ),
                  );
                },
                child: ParticipantCard(
                  contact: f.email ?? f.phone ?? "",
                  name: f.name,
                  id: f.id,
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Builder(
                builder: (context) {
                  var controller = ExpandableController.of(
                    context,
                    required: true,
                  )!;
                  if (participantsList.length > 6) {
                    return Expanded(
                      child: ElevatedButton.icon(
                        label: Text('Ver todos participantes'),
                        onPressed: () {
                          controller.toggle();
                        },
                        icon: Icon(Icons.keyboard_arrow_down, size: 30),
                      ),
                    );
                  }
                  return Text('Adicione mais participantes');
                },
              ),
            ],
          ),
        ],
      );
    }

    buildExpanded1() {
      return Column(
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (_, _) => Container(),
            itemCount: participantsList.length,
            itemBuilder: (context, index) {
              final p = participantsList[index];
              return InkWell(
                onTap: () {
                  context.pushNamed(
                    'view_parti',
                    extra: ShowParticipantArgs(
                      userId: p.id,
                      groupToken: groupToken,
                    ),
                  );
                },
                child: ParticipantCard(
                  contact: p.email ?? p.phone ?? "",
                  name: p.name,
                  id: p.id,
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Builder(
                builder: (context) {
                  var controller = ExpandableController.of(
                    context,
                    required: true,
                  )!;
                  return Expanded(
                    child: ElevatedButton.icon(
                      label: Text('Ver menos'),
                      onPressed: () {
                        controller.toggle();
                      },
                      icon: Icon(Icons.keyboard_arrow_up, size: 30),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      );
    }

    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Container(
          padding: EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: SecretSantaColors.neutral50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: MyColors.sorteadorOrange, width: 1),
            boxShadow: SecretSantaShadows.medium,
          ),
          child: Column(
            spacing: 20,
            children: [
              Row(
                spacing: 5,
                children: [
                  Icon(Icons.group, color: MyColors.sorteadorPurpple),
                  Expanded(
                    child: Text(
                      'Participantes (${participantsList.length})',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (type == BadgeType.pending) ...[
                    IconButton(
                      onPressed: () async {
                        final result = await context.pushNamed(
                          'create_part',
                          extra: CreateParticipantArgs(
                            groupId: groupId,
                            groupCode: groupCode,
                          ),
                        );
                        if (result == true) {
                          context.read<GroupCubit>().show(groupId);
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: MyColors.sorteadorPurpple,
                        size: 30,
                      ),
                    ),
                  ],
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expandable(
                    collapsed: buildCollapsed1(),
                    expanded: buildExpanded1(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
