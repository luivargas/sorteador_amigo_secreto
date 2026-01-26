// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_options.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/view_group/view_group_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class ViewGroup extends StatefulWidget {
  final int groupId;
  const ViewGroup({super.key, required this.groupId});

  @override
  State<ViewGroup> createState() => _ViewGroupBody();
}

class _ViewGroupBody extends State<ViewGroup> {
  final RefreshController _refreshController = RefreshController();
  
  dynamic group;

  Future<void> _onRefresh() async {
    await context.read<GroupCubit>().show(widget.groupId);
  }

  Future<void> _onSubmit(String code, int id) async {
    await context.read<GroupCubit>().raffle(code, id);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

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
              builder: (context) => GroupOptions(groupId: widget.groupId),
            ),
            icon: Icon(Icons.more_vert, size: 30),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocConsumer<GroupCubit, GroupState>(
        listenWhen: (previous, current) =>
            previous.isLoading == true &&
            current.isLoading == false &&
            current.raffled == true,
        listener: (context, state) => _onRefresh(),
        builder: (context, state) {
          while (state.isLoading == true && state.group == null) {
            return Center(
              child: CircularProgressIndicator(
                color: myProgressIndicator.color,
              ),
            );
          }
          if (state.error != null) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: Text('Erro: ${state.error}, tente novamente'),
            );
          }
          if ( state.group != null){
            group = state.group!;
          }else{}
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 60),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        group.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SecretSantaBadge(
                        type: group.raffledAt == null
                            ? type = BadgeType.pending
                            : type = BadgeType.raffled,
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final result = await context.pushNamed(
                            'edit_group',
                            extra: ShowGroupArgs(groupId: widget.groupId,),
                          );
                          if (result == true) {
                            context.read<GroupCubit>().show(widget.groupId);
                          }
                        },
                        icon: Icon(Icons.edit),
                        label: Text('Editar'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ViewGroupCard(
                          type: type,
                          eventLocation:
                              group.location ?? "Não definido",
                          minGiftValue: group.minGiftValue ?? "00,00",
                          maxGiftValue: group.maxGiftValue ?? "00,00",
                          eventDate:
                              group.drawDate?.split(' ').first ??
                              "00/00/0000",
                          eventTime:
                              group.drawDate?.split(' ').last ?? "00:00",
                          groupDescription:
                              group.description ?? "Sem descrição",
                          participants: group.participants.length,
                          participantsList: group.participants,
                          groupId: widget.groupId,
                          groupToken: group.token, groupCode: group.code,
                        ),
                      ),
                      if (group.raffledAt == null &&
                          group.participants.length >= 2) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 40),
                          child: MyButton(
                            onTap: () {
                              _onSubmit(group.code, widget.groupId);
                            },
                            title: "Sortear",
                            icon: Icons.draw,
                          ),
                        ),
                      ],
                    ],
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
