import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/participant_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class ListParticipantsCard extends StatelessWidget {
  final List<Map<String, dynamic>> participantsList;
  const ListParticipantsCard({super.key, required this.participantsList});

  @override
  Widget build(BuildContext context) {
    buildCollapsed1() {
      return Container(
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: SecretSantaColors.neutral50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColors.sorteadorOrange, width: 1),
          boxShadow: SecretSantaShadows.medium,
        ),
        child: Column(
          spacing: 20,
          children: [
            Row(
              spacing: 5,
              children: [
                Icon(Icons.group, color: MyColors.sorteadorPurpple),
                Expanded(
                  child: Text(
                    'Participants (${participantsList.length})',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: MyColors.sorteadorPurpple,
                    size: 30,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (_, _) => Container(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final f = participantsList[0];
                    return InkWell(
                      onTap: () {},
                      child: ParticipantCard(
                        contact: f['email'] ?? f['phone'],
                        name: f['name'],
                        id: f['id'],
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    var controller = ExpandableController.of(
                      context,
                      required: true,
                    )!;
                    return Expanded(
                      child: ElevatedButton.icon(
                        label: Text(
                          'Ver todos participantes'
                        ),
                        onPressed: () {
                          controller.toggle();
                        },
                        icon: Icon(Icons.keyboard_arrow_down, size: 30,),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    buildExpanded1() {
      return Container(
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: SecretSantaColors.neutral50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColors.sorteadorOrange, width: 1),
          boxShadow: SecretSantaShadows.medium,
        ),
        child: Column(
          spacing: 20,
          children: [
            Row(
              spacing: 5,
              children: [
                Icon(Icons.group, color: MyColors.sorteadorPurpple),
                Expanded(
                  child: Text(
                    'Participants (${participantsList.length})',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: MyColors.sorteadorPurpple,
                    size: 30,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (_, _) => Container(),
                  itemCount: participantsList.length,
                  itemBuilder: (context, index) {
                    final p = participantsList[index];
                    return InkWell(
                      onTap: () {},
                      child: ParticipantCard(
                        contact: p['email'] ?? p['phone'],
                        name: p['name'],
                        id: p['id'],
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    var controller = ExpandableController.of(
                      context,
                      required: true,
                    )!;
                    return Expanded(
                      child: ElevatedButton.icon(
                        label: Text(
                          'Ver menos'
                        ),
                        onPressed: () {
                          controller.toggle();
                        },
                        icon: Icon(Icons.keyboard_arrow_up, size: 30,),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expandable(
              collapsed: buildCollapsed1(),
              expanded: buildExpanded1(),
            ),
          ],
        ),
      ),
    );
  }
}
