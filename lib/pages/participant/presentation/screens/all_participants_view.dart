import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
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
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/create_parti_args.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  List<ParticipantModel> _filtered(
    List<ParticipantModel> participants,
  ) {
    if (_query.isEmpty) return participants;
    final q = _query.toLowerCase();
    return participants.where((p) {
      return p.name.toLowerCase().contains(q) ||
          (p.email?.toLowerCase().contains(q) ?? false) ||
          (p.phone?.contains(q) ?? false);
    }).toList();
  }

  Future<void> _onAddParticipant() async {
    final session = getIt<GroupSession>();
    final result = await context.pushNamed(
      'create_part',
      extra: CreateParticipantArgs(
        groupToken: session.token,
        groupCode: session.code,
      ),
    );
    if (result == true && context.mounted) {
      _didCreate = true;
      _onRefresh();
    }
  }

  Future<void> _onRefresh() async {
    final session = getIt<GroupSession>();
    await context.read<GroupCubit>().show(session.code, session.token);
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
        body: Column(
          children: [
            ColoredBox(
              color: SecretSantaColors.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SecretSantaRadius.lg,
                  vertical: SecretSantaRadius.sm,
                ),
                child: MySearchBar(
                  controller: _searchController,
                  hintText: l10n.searchParticipants,
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
            ),
            Expanded(
              child: BlocListener<ParticipantCubit, ParticipantState>(
                listenWhen: (prev, curr) => !prev.deleted && curr.deleted,
                listener: (context, state) {
                  _didCreate = true;
                  _onRefresh();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SecretSantaRadius.lg,
                  ),
                  child: BlocBuilder<GroupCubit, GroupState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final participants = _filtered(
                        state.group?.participants ?? [],
                      );

                      if (participants.isEmpty) {
                        return Center(
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
                        );
                      }

                      return SmartRefresher(
                        controller: _refreshController,
                        onRefresh: _onRefresh,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(
                            top: SecretSantaSpacing.lg,
                            bottom: 100,
                          ),
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
    );
  }
}
