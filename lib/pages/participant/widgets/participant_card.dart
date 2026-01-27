// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/show_parti_args.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class ParticipantCard extends StatefulWidget {
  final String name;
  final String contact;
  final String id;
  final String groupToken;

  const ParticipantCard({
    super.key,
    required this.contact,
    required this.name,
    required this.id,
    required this.groupToken,
  });

  @override
  State<ParticipantCard> createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantCard> {
  Future<void> _delete(BuildContext ctx, String id) async {
    Slidable.of(ctx)?.close();
    context.read<ParticipantCubit>();
  }

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
    return Slidable(
      key: ValueKey(widget.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (ctx) => _delete(ctx, widget.id),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.delete),
                Text("Excluir", overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                context.pushNamed(
                  'view_parti',
                  extra: ShowParticipantArgs(
                    userId: widget.id,
                    groupToken:
                        widget.groupToken,
                  ),
                );
              },
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
                            Text(
                              widget.contact,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
