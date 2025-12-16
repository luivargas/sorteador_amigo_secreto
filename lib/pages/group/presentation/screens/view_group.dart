import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
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
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    await context.read<GroupCubit>().show(int.parse(widget.groupId!));
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
              builder: (context) => GroupOptions(groupId: widget.groupId!),
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
          if (state.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: Text('Tente novamente'),
            );
          }
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 60),
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
                              "00/00/0000",
                          eventTime:
                              state.group?.drawDate?.split(' ').last ?? "00:00",
                          groupDescription:
                              state.group?.description ?? "Sem descrição",
                          participants: state.group!.participants.length,
                          participantsList: state.group!.participants,
                          groupId: int.parse(widget.groupId!),
                          groupCode: state.group!.code,
                        ),
                      ),
                      if (state.group?.raffledAt == null &&
                          state.group!.participants.length >= 2) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 40),
                          child: MyButton(
                            onTap: () {
                              _onSubmit(
                                state.group!.code,
                                int.parse(widget.groupId!),
                              );
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
