import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class GroupCard extends StatefulWidget {
  final String groupName;
  final String? groupDate;
  final String? groupPrice;
  final String? groupImage;
  final int groupId;
  final int index;
  final SlidableController slideController;

  const GroupCard({
    super.key,
    required this.groupName,
    this.groupImage,
    required this.index,
    required this.slideController,
    this.groupDate,
    this.groupPrice,
    required this.groupId,
  });

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {

  Future<void> _delete(int id) {
    final delete = getIt<GroupCubit>().delete(id);
    widget.slideController.openEndActionPane();
    return delete;
  }

  Text main() {
    String text = widget.groupName.trim();
    String firstWord = text.split(' ').first[0].toUpperCase();
    String lastWord = text.split(' ').last[0].toUpperCase();

    int voidIndex = text.indexOf(' ');
    if (voidIndex != -1 && voidIndex < text.length - 1) {
      return Text(
        "$firstWord$lastWord",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 35,
        ),
      );
    }
    return Text(
      firstWord,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 35,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Slidable(
            // Specify a key if the Slidable is dismissible.
            key: ValueKey(widget.groupId),
            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),
              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),
              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                CustomSlidableAction(
                  onPressed: (_) => _delete(widget.groupId),
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete),
                      Text("Excluir", overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  // icon: Icons.delete,
                  // label: 'Excluir',
                ),
                SlidableAction(
                  onPressed: (_) => widget.slideController.close(),
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
                  onPressed: (_) => widget.slideController.openEndActionPane(),
                  backgroundColor: const Color(0xFF7BC043),
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Arquivar',
                ),
              ],
            ),

            // The child of the Slidable is what the user sees when the
            // component is not dragged.
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
                        width: 70,
                        height: 70,
                        child: Center(child: main()),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.groupName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void doNothing(BuildContext context) {}
