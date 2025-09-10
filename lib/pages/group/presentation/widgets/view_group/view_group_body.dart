import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/view_group/view_group_card.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class ViewGroupBody extends StatefulWidget {
  const ViewGroupBody({super.key});

  @override
  State<ViewGroupBody> createState() => _ViewGroupBody();
}

class _ViewGroupBody extends State<ViewGroupBody> {
  _ViewGroupBody();
  @override
  Widget build(BuildContext context) {
    final String groupName = "Grupo da Kitty";
    final String eventLocation = "Cada da Kitty";
    final String minGiftValue = "50,00";
    final String maxGiftValue = "100,00";
    final String eventDate = "25/12/2025";
    final String eventTime = "20:30";
    final String groupDescription =
        "Festa na casa da Kittyzinha, por favor levar sua bebida!";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: MyColors.sorteadorOrange),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ViewGroupCard(
                groupName: groupName,
                eventLocation: eventLocation,
                minGiftValue: minGiftValue,
                maxGiftValue: maxGiftValue,
                eventDate: eventDate,
                eventTime: eventTime,
                groupDescription: groupDescription,
              ),
            ),
            Column(),
          ],
        ),
      ),
    );
  }
}
