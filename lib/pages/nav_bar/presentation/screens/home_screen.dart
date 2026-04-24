// ignore_for_file: use_build_context_synchronously
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/app_alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/card_color.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_search_bar.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_card.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/widgets/home_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class HomeScreen extends StatelessWidget {
  final List<AuthGroupModel> groups;
  const HomeScreen({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return _HomeView(groups: groups);
  }
}

class _HomeView extends StatefulWidget {
  final List<AuthGroupModel> groups;
  const _HomeView({required this.groups});

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final RefreshController _homeRefreshController = RefreshController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _hasGroups = false;

  @override
  void initState() {
    super.initState();
    _hasGroups = widget.groups.isNotEmpty;
  }

  Future<void> _onRefresh() async {
    await context.read<GroupCubit>().refreshGroups();
    _homeRefreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _homeRefreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(),
      body: BlocListener<GroupCubit, GroupState>(
        listenWhen: (prev, curr) =>
            prev.groups != curr.groups ||
            (!prev.logout && curr.logout) ||
            (prev.error == null && curr.error != null && !curr.logout),
        listener: (context, state) async {
          if (state.logout) {
            final l10n = AppLocalizations.of(context)!;
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
            final l10n = AppLocalizations.of(context)!;
            AppAlert.showBanner(
              context,
              title: l10n.errorTitle,
              message: state.error!.localize(context),
              type: AlertType.warning,
            );
            return;
          }
          setState(() => _hasGroups = state.groups.isNotEmpty);
        },
        child: Column(
          children: [
            ColoredBox(
              color: SecretSantaColors.background,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  SecretSantaSpacing.lg,
                  SecretSantaSpacing.sm,
                  SecretSantaSpacing.lg,
                  SecretSantaSpacing.lg,
                ),
                child: _SearchBar(l10n: l10n),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SecretSantaSpacing.lg),
                child: SmartRefresher(
                  controller: _homeRefreshController,
                  onRefresh: _onRefresh,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: SecretSantaSpacing.lg,
                          ),
                          child: HomeCard(hasGroups: _hasGroups),
                        ),
                      ),
                  
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: SecretSantaSpacing.sm),
                          child: Text(
                            l10n.homeTitle,
                            style: SecretSantaTextStyles.titleSmall,
                          ),
                        ),
                      ),
                  
                      BlocBuilder<GroupCubit, GroupState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: SecretSantaColors.accent,
                                ),
                              ),
                            );
                          }
                  
                          if (state.error != null) {
                            final msg = state.error == AppError.unauthorized
                                ? l10n.sessionExpired
                                : state.error!.localize(context);
                            return SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(child: Text(msg)),
                            );
                          }
                  
                          if (state.filtered.isEmpty) {
                            final isSearching = state.search.isNotEmpty;
                            final isFiltering = state.filter != GroupFilter.all;
                            return SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                spacing: 8,
                                children: [
                                  Icon(
                                    isSearching || isFiltering
                                        ? Icons.search_off
                                        : Icons.group_outlined,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    isSearching
                                        ? '"${state.search}" — ${l10n.noGroupsFound.toLowerCase()}'
                                        : l10n.noGroupsFound,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                          return SliverPadding(
                            padding: const EdgeInsets.only(bottom: 150),
                            sliver: SliverList.separated(
                              itemCount: state.filtered.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final g = state.filtered[index];
                                return GroupCard(
                                  onPress: () async {
                                    await context.pushNamed(
                                      'view_group',
                                      extra: ShowGroupArgs(
                                        code: g.code,
                                        token: g.token,
                                        name: g.name,
                                      ),
                                    );
                                    _onRefresh();
                                  },
                                  index: index,
                                  groupName: g.name,
                                  isRaffled: g.isRaffled,
                                  color: CardColor.getColor(index),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
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

class _SearchBar extends StatelessWidget {
  final AppLocalizations l10n;

  const _SearchBar({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        MySearchBar(
          hintText: l10n.searchGroup,
          onChanged: (v) => context.read<GroupCubit>().onSearchChanged(v),
        ),
        BlocBuilder<GroupCubit, GroupState>(
          buildWhen: (prev, cur) => prev.filter != cur.filter,
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8,
                children: [
                  _FilterChip(
                    label: l10n.filterAll,
                    selected: state.filter == GroupFilter.all,
                    onSelected: () => context
                        .read<GroupCubit>()
                        .onFilterChanged(GroupFilter.all),
                  ),
                  _FilterChip(
                    label: l10n.badgePending,
                    selected: state.filter == GroupFilter.pending,
                    onSelected: () => context
                        .read<GroupCubit>()
                        .onFilterChanged(GroupFilter.pending),
                    color: SecretSantaColors.accent3,
                  ),
                  _FilterChip(
                    label: l10n.badgeRaffled,
                    selected: state.filter == GroupFilter.raffled,
                    onSelected: () => context
                        .read<GroupCubit>()
                        .onFilterChanged(GroupFilter.raffled),
                    color: SecretSantaColors.accent,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final Color? color;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? SecretSantaColors.accent2;

    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? activeColor : SecretSantaColors.neutral50,
          borderRadius: BorderRadius.circular(SecretSantaRadius.full),
          border: Border.all(
            color: selected ? activeColor : SecretSantaColors.neutral200,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected
                ? SecretSantaColors.neutral50
                : SecretSantaColors.neutral600,
          ),
        ),
      ),
    );
  }
}
