import 'package:flutter/material.dart';

class ViewGroupCard extends StatelessWidget {
  final String groupName;
  final String eventLocation;
  final String minGiftValue;
  final String maxGiftValue;
  final String eventDate;
  final String eventTime;
  final String groupDescription;

  const ViewGroupCard({
    super.key,
    required this.groupName,
    required this.eventLocation,
    required this.minGiftValue,
    required this.maxGiftValue,
    required this.eventDate,
    required this.eventTime,
    required this.groupDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Nome do grupo: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(groupName),
                        ],
                      ),
                      Row(children: [Text("Local: $eventLocation")]),
                      Row(
                        children: [
                          Text(
                            'Valor de R\$ $minGiftValue até R\$ $maxGiftValue',
                          ),
                        ],
                      ),
                      Text('Data: $eventDate Horário: $eventTime'),
                      Text('Descricrição do grupo: $groupDescription'),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit_note_rounded, size: 30),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.share, size: 30)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
