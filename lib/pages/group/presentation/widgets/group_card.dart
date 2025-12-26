import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class GroupCard extends StatefulWidget {
  final String groupName;
  final int groupId;
  final int index;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.groupId,
    required this.index,
  });

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  Future<void> _delete(BuildContext ctx, int id) async {
    // ✅ fecha o Slidable desse item, se existir
    Slidable.of(ctx)?.close();

    await getIt<GroupCubit>().delete(id);
  }

  Text _initials() {
    final text = widget.groupName.trim();
    final parts = text.split(' ').where((p) => p.isNotEmpty).toList();

    final first = parts.first[0].toUpperCase();
    final last = parts.length > 1 ? parts.last[0].toUpperCase() : '';

    return Text(
      "$first$last",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.groupId),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (ctx) => _delete(ctx, widget.groupId),
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
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Compartilhar',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: (context) {},
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Arquivar',
          ),
        ],
      ),

      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: MyColors.sorteadorGradient,
                    borderRadius: BorderRadius.circular(90),
                  ),
                  width: 60,
                  height: 60,
                  child: Center(child: _initials()),
                ),
              ),
              Expanded(
                child: Text(
                  widget.groupName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: MyColors.sorteadorOrange,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
