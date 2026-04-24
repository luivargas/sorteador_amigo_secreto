// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/app_alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/card_color.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_search_bar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/participant_list_item.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class AllParticipantsView extends StatefulWidget {
  const AllParticipantsView({super.key});

  @override
  State<AllParticipantsView> createState() => _AllParticipantsViewState();
}

class _AllParticipantsViewState extends State<AllParticipantsView> {
  final RefreshController _refreshController = RefreshController();
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _didCreate = false;
  final group = getIt<GroupSession>();

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  List<ParticipantModel> _filtered(List<ParticipantModel> participants) {
    if (_query.isEmpty) return participants;
    final q = _query.toLowerCase();
    return participants.where((p) {
      return p.name.toLowerCase().contains(q) ||
          (p.email?.toLowerCase().contains(q) ?? false) ||
          (p.phone?.contains(q) ?? false);
    }).toList();
  }

  Future<void> _onAddParticipant() async {
    final result = await context.pushNamed('create_part');
    if (result == true && context.mounted) {
      _didCreate = true;
      _onRefresh();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<GroupCubit>().show(group.code, group.token);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.pop(_didCreate);
      },
      child: Scaffold(
        appBar: MyAppBar(),
        floatingActionButton: !getIt<GroupSession>().isRaffled
            ? FloatingActionButton(
                onPressed: _onAddParticipant,
                backgroundColor: SecretSantaColors.accent,
                child: const Icon(
                  Icons.person_add_alt_1,
                  color: SecretSantaColors.neutral50,
                ),
              )
            : null,
        body: BlocListener<GroupCubit, GroupState>(
          listenWhen: (prev, curr) =>
              (!prev.logout && curr.logout) ||
              (prev.error == null && curr.error != null && !curr.logout),
          listener: (context, state) async {
            final l10n = AppLocalizations.of(context)!;
            if (state.logout) {
              await AppAlert.showAlertDialog(
                context,
                title: l10n.errorTitle,
                message: l10n.errorUnauthorized,
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                      context.goNamed('request_token');
                    },
                    child: Text(l10n.ok),
                  ),
                ],
              );
              return;
            }
            if (state.error != null) {
              AppAlert.showBanner(
                context,
                title: l10n.errorTitle,
                message: state.error!.localize(context),
                type: AlertType.warning,
              );
            }
          },
          child: Column(
            children: [
              ColoredBox(
                color: SecretSantaColors.background,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SecretSantaSpacing.lg,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: SecretSantaSpacing.sm,
                        ),
                        child: Text(
                          l10n.allParticipantsList,
                          style: SecretSantaTextStyles.titleMedium,
                            textAlign: TextAlign.center,
                        ),
                      ),
                      ColoredBox(
                        color: SecretSantaColors.background,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: SecretSantaSpacing.sm,
                          ),
                          child: MySearchBar(
                            controller: _searchController,
                            hintText: l10n.searchParticipants,
                            onChanged: (v) => setState(() => _query = v),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SecretSantaSpacing.lg,
                  ),
                  child: BlocListener<ParticipantCubit, ParticipantState>(
                    listenWhen: (prev, curr) =>
                        (!prev.deleted && curr.deleted) ||
                        (prev.error == null && curr.error != null),
                    listener: (context, state) {
                      if (state.deleted) {
                        AppAlert.showBanner(
                          context,
                          message: l10n.participantDeletedSuccess(''),
                          type: AlertType.success,
                        );
                        _didCreate = true;
                        _onRefresh();
                        return;
                      }
                      if (state.error != null) {
                        final l10n = AppLocalizations.of(context)!;
                        AppAlert.showBanner(
                          context,
                          title: l10n.errorTitle,
                          message: state.error!.localize(context),
                          type: AlertType.warning,
                        );
                      }
                    },
                    child: BlocBuilder<GroupCubit, GroupState>(
                      builder: (context, state) {
                        final participants = _filtered(
                          state.group?.participants ?? [],
                        );
                        return SmartRefresher(
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          child: state.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : participants.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.people_outline,
                                        size: 64,
                                        color: SecretSantaColors.neutral300,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        l10n.noGroupsFound,
                                        style: TextStyle(
                                          color: SecretSantaColors.neutral500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.separated(
                                  padding: const EdgeInsets.only(bottom: 100),
                                  itemCount: participants.length,
                                  separatorBuilder: (_, _) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final p = participants[index];
                                    return ParticipantListItem(
                                      participant: p,
                                      color: CardColor.getColor(index),
                                      onChanged: () {
                                        _didCreate = true;
                                        _onRefresh();
                                      },
                                    );
                                  },
                                ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
