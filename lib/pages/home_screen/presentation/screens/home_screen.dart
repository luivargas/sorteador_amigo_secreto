import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_home_app_bar.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_card.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/database/group_db.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/isar_group_model.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();
  final TextEditingController searchControler = TextEditingController();

  late Future<List<IsarGroupModel>> _futureGroups;

  @override
  void initState() {
    super.initState();
    _futureGroups = GroupDB().getAllGroups();
    searchControler.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (!mounted) return;
    setState(() {});
  }

  void _reload() {
    if (!mounted) return;
    setState(() {
      _futureGroups = GroupDB().getAllGroups();
    });
  }

  Future<void> _onRefresh() async {
    _reload();
    if (!mounted) return;
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    searchControler.removeListener(_onSearchChanged);
    searchControler.dispose();
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
              child: MyHomeAppBar(reload: _reload),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextField(
                controller: searchControler,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Buscar grupo',
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
                      child: FutureBuilder<List<IsarGroupModel>>(
                        future: _futureGroups,
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: myProgressIndicator.color,
                                ),
                              ),
                            );
                          }
                          if (snap.hasError) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Erro ao carregar grupos: ${snap.error}',
                              ),
                            );
                          }

                          final data = snap.data ?? const <IsarGroupModel>[];
                          final q = searchControler.text.trim().toLowerCase();
                          final filtered = q.isEmpty
                              ? data
                              : data
                                    .where(
                                      (g) => g.name.toLowerCase().contains(q),
                                    )
                                    .toList();

                          if (filtered.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(24),
                              child: Center(
                                child: Text('Nenhum grupo encontrado'),
                              ),
                            );
                          }
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filtered.length,
                            separatorBuilder: (_, _) => const SizedBox.shrink(),
                            itemBuilder: (context, index) {
                              final g = filtered[index];
                              return InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    'view_group',
                                    extra: ShowGroupArgs(groupId: g.id),
                                  );
                                },
                                child: GroupCard(
                                  index: index,
                                  groupName: g.name,
                                  groupId: g.id,
                                ),
                              );
                            },
                          );
                        },
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
