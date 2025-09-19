import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/components/group_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/widgets/filter_sheet.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class HomeScreenBody extends StatefulWidget {
  final TextEditingController searchControler;

  const HomeScreenBody({super.key, required this.searchControler});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with SingleTickerProviderStateMixin {
  late final slideController = SlidableController(this);

  final List<Map<String, String>> allGroups = [
    {
      "groupName": "Grupo Labrador",
      "groupImage": "./assets/logos/icons/Logo_9.png",
      "groupDate": "14/02/2025",
      "groupPrice": "180,00",
    },
    {
      "groupName": "Grupo Siamês",
      "groupImage": "./assets/logos/icons/Logo_8.png",
      "groupDate": "02/03/2025",
      "groupPrice": "95,00",
    },
    {
      "groupName": "Grupo Pug",
      "groupImage": "./assets/logos/icons/Logo_10.png",
      "groupDate": "27/01/2025",
      "groupPrice": "220,00",
    },
    {
      "groupName": "Grupo Persa",
      "groupImage": "./assets/logos/icons/Logo_9.png",
      "groupDate": "18/04/2025",
      "groupPrice": "150,00",
    },
    {
      "groupName": "Grupo Golden Retriever",
      "groupImage": "./assets/logos/icons/Logo_10.png",
      "groupDate": "09/05/2025",
      "groupPrice": "300,00",
    },
    {
      "groupName": "Grupo Bulldog Francês",
      "groupImage": "./assets/logos/icons/Logo_8.png",
      "groupDate": "15/06/2025",
      "groupPrice": "210,00",
    },
    {
      "groupName": "Grupo Maine Coon",
      "groupImage": "./assets/logos/icons/Logo_9.png",
      "groupDate": "01/07/2025",
      "groupPrice": "135,00",
    },
    {
      "groupName": "Grupo Shih Tzu",
      "groupImage": "./assets/logos/icons/Logo_9.png",
      "groupDate": "23/08/2025",
      "groupPrice": "280,00",
    },
    {
      "groupName": "Grupo Ragdoll",
      "groupImage": "./assets/logos/icons/Logo_10.png",
      "groupDate": "30/09/2025",
      "groupPrice": "170,00",
    },
    {
      "groupName": "Grupo Border Collie",
      "groupImage": "./assets/logos/icons/Logo_9.png",
      "groupDate": "19/10/2025",
      "groupPrice": "60,00",
    },
  ];

  late List<Map<String, String>> filteredGroups;

  void applyFilter([String? value]) {
    final queryRaw = value ?? widget.searchControler.text;
    final query = queryRaw.toLowerCase().trim();

    setState(() {
      if (query.isEmpty) {
        filteredGroups = List.from(allGroups);
      } else {
        filteredGroups = allGroups.where((e) {
          final name = (e['groupName'] ?? '').toLowerCase();
          return name.contains(query);
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    filteredGroups = List.from(allGroups);
    widget.searchControler.addListener(applyFilter);
  }

  @override
  void dispose() {
    widget.searchControler.removeListener(applyFilter);
    slideController.dispose();
    super.dispose();
  }

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    filteredGroups.add(
      (filteredGroups.length + 1).toString() as Map<String, String>,
    );
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        bottom: false,
        child: SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: MyHomeAppBar()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: widget.searchControler,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: MyColors.sorteadorOrange,
                            ),
                            hintText: 'Buscar grupo',
                          ),
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Theme.of(context).canvasColor,
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return const FilterSheet();
                              },
                            );
                          },
                          icon: Icon(
                            Icons.filter_alt,
                            size: 30,
                            color: MyColors.sorteadorOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList.builder(
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredGroups[index];
                  return InkWell(
                    onTap: () {
                      print('Deu bom: Card selecionado $index');
                    },
                    child: GroupCard(
                      slideController: slideController,
                      index: index,
                      groupName: item['groupName'],
                      groupImage: item['groupImage'],
                      groupDate: item['groupDate'],
                      groupPrice: item['groupPrice'],
                    ),
                  );
                },
                itemCount: filteredGroups.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
