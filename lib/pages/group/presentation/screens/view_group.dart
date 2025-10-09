import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/view_group/view_group_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/util/contants.dart';

class ViewGroup extends StatefulWidget {
  const ViewGroup({super.key});

  @override
  State<ViewGroup> createState() => _ViewGroupBody();
}

class _ViewGroupBody extends State<ViewGroup> {
  @override
  Widget build(BuildContext context) {
    final BadgeType type = BadgeType.raffled;
    final String groupName = "Grupo da Kitty";
    final String eventLocation = "Casa da Vó Joana do Juvenal da silva";
    final String minGiftValue = "50,00";
    final String maxGiftValue = "100,00";
    final String eventDate = "25/12/2025";
    final String eventTime = "20:30";
    final String groupDescription =
        "Festa na casa da Kittyzinha, por favor levar sua bebida!";

    return Scaffold(
      appBar: MyAppBar(
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet<void>(
              backgroundColor: Theme.of(context).canvasColor,
              context: context,
              builder: (context) => GroupButton(),
            ),
            icon: Icon(
              Icons.add_circle,
              color: MyColors.sorteadorOrange,
              size: 30,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SecretSantaBadge(type: type),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ViewGroupCard(
                        eventLocation: eventLocation,
                        minGiftValue: minGiftValue,
                        maxGiftValue: maxGiftValue,
                        eventDate: eventDate,
                        eventTime: eventTime,
                        groupDescription: groupDescription,
                        participants: participantList.length,
                        participantsList: participantList,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: MyButton(
                        onTap: () {},
                        title: "Sortear",
                        icon: Icons.draw,
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
