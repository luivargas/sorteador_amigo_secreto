// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/view_group/view_group_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class ViewGroup extends StatefulWidget {
  final int groupId;
  const ViewGroup({super.key, required this.groupId});

  @override
  State<ViewGroup> createState() => _ViewGroupBody();
}

class _ViewGroupBody extends State<ViewGroup> {
  final RefreshController _refreshController = RefreshController();

  ShowGroupModel? group;

  Future<void> _onShare() async {
    final title = AppLocalizations.of(context)!.shareLinkTitle;
    await SharePlus.instance.share(
      ShareParams(
        uri: Uri.parse('https://sorteador.com.br'),
        title: title,
        subject: title,
      ),
    );

  }

  Future<void> _onRefresh() async {
    await context.read<GroupCubit>().show(widget.groupId);
        _refreshController.refreshCompleted();
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
            onPressed: () => _onShare(),
            icon: Icon(Icons.share, size: 30),
          ),
        ], title: '',
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocConsumer<GroupCubit, GroupState>(
        listenWhen: (previous, current) =>
            previous.isLoading &&
            !current.isLoading &&
            current.raffled,
        listener: (context, state) => _onRefresh(),
        builder: (context, state) {
          if (state.isLoading && state.group == null) {
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
              child: Text(AppLocalizations.of(context)!.errorTryAgain(state.error!)),
            );
          }
          if (state.group != null) {
            group = state.group!;
          }
          if (group == null) {
            return const SizedBox.shrink();
          }
          final g = group!;
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
                        g.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SecretSantaBadge(
                        type: g.raffledAt == null
                            ? type = BadgeType.pending
                            : type = BadgeType.raffled,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              final result = await context.pushNamed(
                                'edit_group',
                                extra: ShowGroupArgs(groupId: widget.groupId),
                              );
                              if (result == true) {
                                context.read<GroupCubit>().show(widget.groupId);
                              }
                            },
                            label: Row(
                              spacing: 7,
                              children: [Icon(Icons.edit), Text(AppLocalizations.of(context)!.edit)],
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ViewGroupCard(
                          type: type,
                          eventLocation: g.location ?? AppLocalizations.of(context)!.notDefined,
                          minGiftValue: g.minGiftValue ?? "00,00",
                          maxGiftValue: g.maxGiftValue ?? "00,00",
                          eventDate:
                              g.drawDate?.split(' ').first ?? "00/00/0000",
                          eventTime: g.drawDate?.split(' ').last ?? "00:00",
                          groupDescription:
                              g.description ?? AppLocalizations.of(context)!.noDescription,
                          participants: g.participants.length,
                          participantsList: g.participants,
                          groupId: widget.groupId,
                          groupToken: g.token,
                          groupCode: g.code,
                        ),
                      ),
                      if (g.raffledAt == null &&
                          g.participants.length >= 2) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 40),
                          child: MyGradientButton(
                            onTap: () {
                              _onSubmit(g.code, widget.groupId);
                            },
                            title: AppLocalizations.of(context)!.drawButton,
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

