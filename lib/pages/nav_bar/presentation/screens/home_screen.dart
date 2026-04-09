import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_search_bar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_card.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/widgets/home_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';


import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  final List<AuthGroupModel> groups;
  const HomeScreen({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..loadGroups(groups),
      child: _HomeView(groups: groups),
    );
  }
}

class _HomeView extends StatefulWidget {
  final List<AuthGroupModel> groups;
  const _HomeView({required this.groups});

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final RefreshController _refreshController = RefreshController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _searchBarElevated = false;

  final List<Color> cardColors = [
    SecretSantaColors.accent,
    SecretSantaColors.accent2,
  ];
  Color getColor(int index) => cardColors[index % cardColors.length];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final elevated = _scrollController.offset > 0;
    if (elevated != _searchBarElevated) {
      setState(() => _searchBarElevated = elevated);
    }
  }

  Future<void> _onRefresh() async {
    await context.read<HomeCubit>().refreshGroups();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          _SearchBar(
            searchController: _searchController,
            l10n: l10n,
            elevated: _searchBarElevated,
          ),

          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: HomeCard(),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                      child: Text(
                        l10n.homeTitle,
                        style: SecretSantaTextStyles.titleSmall,
                      ),
                    ),
                  ),

                  BlocBuilder<HomeCubit, HomeState>(
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
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                        sliver: SliverList.separated(
                          itemCount: state.filtered.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final g = state.filtered[index];
                            return InkWell(
                              onTap: () => context.pushNamed(
                                'view_group',
                                extra: ShowGroupArgs(
                                  code: g.code,
                                  token: g.token,
                                  name: g.name,
                                ),
                              ),
                              child: GroupCard(
                                index: index,
                                groupName: g.name,
                                groupToken: g.token,
                                groupCode: g.code,
                                isRaffled: g.isRaffled,
                                color: getColor(index),
                              ),
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
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController _searchController;
  final AppLocalizations l10n;
  final bool elevated;

  const _SearchBar({
    required TextEditingController searchController,
    required this.l10n,
    required this.elevated,
  }) : _searchController = searchController;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevated ? 3 : 0,
      color: SecretSantaColors.background,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            MySearchBar(
              controller: _searchController,
              hintText: l10n.searchGroup,
              onChanged: (v) => context.read<HomeCubit>().onSearchChanged(v),
            ),
            BlocBuilder<HomeCubit, HomeState>(
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
                            .read<HomeCubit>()
                            .onFilterChanged(GroupFilter.all),
                      ),
                      _FilterChip(
                        label: l10n.badgePending,
                        selected: state.filter == GroupFilter.pending,
                        onSelected: () => context
                            .read<HomeCubit>()
                            .onFilterChanged(GroupFilter.pending),
                        color: SecretSantaColors.accent3,
                      ),
                      _FilterChip(
                        label: l10n.badgeRaffled,
                        selected: state.filter == GroupFilter.raffled,
                        onSelected: () => context
                            .read<HomeCubit>()
                            .onFilterChanged(GroupFilter.raffled),
                        color: SecretSantaColors.accent
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? activeColor : SecretSantaColors.neutral200,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : SecretSantaColors.neutral600,
          ),
        ),
      ),
    );
  }
}
