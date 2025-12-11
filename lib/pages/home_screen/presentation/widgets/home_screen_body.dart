import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_card.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/database/group_db.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/isar_group_model.dart';

class HomeScreenBody extends StatefulWidget {
  final TextEditingController searchControler;
  const HomeScreenBody({super.key, required this.searchControler});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with SingleTickerProviderStateMixin {
  late final SlidableController slideController = SlidableController(this);
  final RefreshController _refreshController = RefreshController();

  late Future<List<IsarGroupModel>> _futureGroups;

  @override
  void initState() {
    super.initState();
    _futureGroups = GroupDB().getAllGroups();
    widget.searchControler.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {});
  }

  void _reload() {
    setState(() {
      _futureGroups = GroupDB().getAllGroups();
    });
  }

  Future<void> _onRefresh() async {
    _reload();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    widget.searchControler.removeListener(_onSearchChanged);
    slideController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: MyHomeAppBar(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: widget.searchControler,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Buscar grupo',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FutureBuilder<List<IsarGroupModel>>(
                  future: _futureGroups,
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snap.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text('Erro ao carregar grupos: ${snap.error}'),
                      );
                    }
                    final data = snap.data ?? const <IsarGroupModel>[];
                    final q = widget.searchControler.text.trim().toLowerCase();
                    final filtered = q.isEmpty
                        ? data
                        : data
                              .where((g) => (g.name).toLowerCase().contains(q))
                              .toList();

                    if (filtered.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: Text('Nenhum grupo encontrado')),
                      );
                    }
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) => Container(),
                      itemBuilder: (context, index) {
                        final g = filtered[index];
                        return InkWell(
                          onTap: () {
                            context.pushNamed(
                              'view_group',
                              pathParameters: {'id': '${g.id}'},
                            );
                          },
                          child: GroupCard(
                            slideController: slideController,
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
    );
  }
}
