// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_options.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/view_group/view_group_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class ViewGroup extends StatefulWidget {
  final String? groupId;
  const ViewGroup({super.key, required this.groupId});

  @override
  State<ViewGroup> createState() => _ViewGroupBody();
}

class _ViewGroupBody extends State<ViewGroup> {
  @override
  Widget build(BuildContext context) {
    BadgeType type;
    return Scaffold(
      appBar: MyAppBar(
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet<void>(
              backgroundColor: Theme.of(context).canvasColor,
              context: context,
              builder: (context) => GroupOptions(groupId: widget.groupId!),
            ),
            icon: Icon(Icons.more_vert, size: 30),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, state) {
          if (state.showed != true || state.isLoading != false) {
            return const Center(child: CircularProgressIndicator());
          } 
          if (state.error != null) {
            return Center(child: Text('Tente novamente'));
          }
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state.group!.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SecretSantaBadge(
                          type: state.group?.raffledAt == null
                              ? type = BadgeType.pending
                              : type = BadgeType.raffled,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ViewGroupCard(
                            type: type,
                            eventLocation:
                                state.group?.location ?? "Não definido",
                            minGiftValue: state.group?.minGiftValue ?? "00,00",
                            maxGiftValue: state.group?.maxGiftValue ?? "00,00",
                            eventDate:
                                state.group?.drawDate?.split(' ').first ??
                                "00/00/00",
                            eventTime:
                                state.group?.drawDate?.split(' ').last ??
                                "00:00",
                            groupDescription:
                                state.group?.description ?? "Sem descrição",
                            participants: state.group!.participants.length,
                            participantsList: state.group!.participants,
                            groupId: int.parse(widget.groupId!),
                            groupCode: state.group!.code,
                          ),
                        ),
                        if (state.group?.raffledAt == null) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: MyButton(
                              onTap: () {},
                              title: "Sortear",
                              icon: Icons.draw,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
