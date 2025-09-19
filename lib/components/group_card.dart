import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class GroupCard extends StatelessWidget {
  final String? groupName;
  final String? groupDate;
  final String? groupPrice;
  final String? groupImage;
  final int index;
  final SlidableController slideController;

  const GroupCard({
    super.key,
    required this.groupName,
    this.groupImage,
    required this.index,
    required this.slideController,
    required this.groupDate,
    required this.groupPrice,
  });

  Text main() {
    String text = groupName!.trim();
    String secondLetter = "";

    int voidIndex = text.indexOf(' ');
    String firstIndex = text.substring(0, 1).toUpperCase();
    if (voidIndex != -1 && voidIndex < text.length - 1) {
      secondLetter = text.substring(voidIndex + 1, voidIndex + 2).toUpperCase();
      return Text(
        "$firstIndex$secondLetter",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35),
      );
    }
    return Text(
      firstIndex,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35),
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
            key: ValueKey(index),

            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),

              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),

              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: doNothing,
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: doNothing,
                  backgroundColor: const Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Share',
                ),
              ],
            ),

            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  onPressed: (_) => slideController.openEndActionPane(),
                  backgroundColor: const Color(0xFF7BC043),
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Archive',
                ),
                SlidableAction(
                  onPressed: (_) => slideController.close(),
                  backgroundColor: const Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.save,
                  label: 'Save',
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
                          gradient: MyColors.buttonGradient,
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
                          groupName!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(groupDate!),
                        Text(groupPrice!),
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
