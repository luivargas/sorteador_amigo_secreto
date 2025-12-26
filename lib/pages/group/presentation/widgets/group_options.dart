import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class GroupOptions extends StatelessWidget {
  final String? groupId;
  const GroupOptions({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.horizontal_rule, size: 45)],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                "Opções do grupo",
                style: myTheme.textTheme.titleSmall,
              ),
            ),
            Column(
              spacing: 10,
              children: [
                // Column(
                //   spacing: 10,
                //   children: [
                //     MyButton(
                //       title: 'Editar grupo',
                //       icon: Icons.edit_square,
                //       onTap: () {
                //         context.pushNamed(
                //           'edit_group',
                //           pathParameters: {"id": groupId!},
                //         );
                //       },
                //     ),
                //   ],
                // ),
                Column(
                  spacing: 10,
                  children: [
                    MyButton(
                      title: "Compartilhar",
                      icon: Icons.share,
                      onTap: () {},
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    MyButton(
                      title: "Arquivar",
                      icon: Icons.archive,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
