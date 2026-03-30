import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_home_app_bar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_card.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

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

  Future<void> _onRefresh() async {
    await context.read<HomeCubit>().refreshGroups();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: MyHomeAppBar(
                reload: () => context.read<HomeCubit>().refreshGroups(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<HomeCubit>().onSearchChanged(value);
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: AppLocalizations.of(context)!.searchGroup,
                ),
              ),
            ),

            Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              if (state.isLoading) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 40),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: myProgressIndicator.color,
                                    ),
                                  ),
                                );
                              }

                              if (state.error != null) {
                                final l10n = AppLocalizations.of(context)!;
                                final msg = state.error == 'sessionExpired'
                                    ? l10n.sessionExpired
                                    : l10n.errorLoadingGroups(state.error!);
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Center(child: Text(msg)),
                                );
                              }

                              if (state.filtered.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.noGroupsFound,
                                    ),
                                  ),
                                );
                              }

                              return ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.filtered.length,
                                separatorBuilder: (_, _) => const SizedBox.shrink(),
                                itemBuilder: (context, index) {
                                  final g = state.filtered[index];
                                  return InkWell(
                                    onTap: () {
                                      context.pushNamed(
                                        'view_group',
                                        extra: ShowGroupArgs(
                                          code: g.code,
                                          token: g.token,
                                        ),
                                      );
                                    },
                                    child: GroupCard(
                                      index: index,
                                      groupName: g.name,
                                      groupToken: g.token,
                                      groupCode: g.code,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
