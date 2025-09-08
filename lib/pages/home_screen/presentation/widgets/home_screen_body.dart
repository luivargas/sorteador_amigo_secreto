import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/components/group_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/widgets/filter_sheet.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 300,
          maxWidth: 600,
          minHeight: 400,
          maxHeight: 800,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                spacing: 10,
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
                  SizedBox(
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
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
                      icon: Icon(Icons.filter_alt, size: 30),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
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
          ],
        ),
      ),
    );
  }
}
