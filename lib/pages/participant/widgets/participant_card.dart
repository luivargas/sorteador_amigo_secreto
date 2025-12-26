// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class ParticipantCard extends StatefulWidget {
  late String name;
  late String contact;
  late String id;


  ParticipantCard({
    super.key,
    required this.contact,
    required this.name,
    required this.id
  });

  @override
  State<ParticipantCard> createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantCard> {
  Text main() {
    String text = widget.name.trim();
    String firstWord = text.split(' ').first[0].toUpperCase();
    String lastWord = text.split(' ').last[0].toUpperCase();

    int voidIndex = text.indexOf(' ');
    if (voidIndex != -1 && voidIndex < text.length - 1) {
      return Text(
        "$firstWord$lastWord",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 30,
        ),
      );
    }
    return Text(
      firstWord,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: MyColors.sorteadorGradient,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      width: 60,
                      height: 60,
                      child: Center(child: main()),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(widget.contact,overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
