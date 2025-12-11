import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';

class GroupButton extends StatelessWidget {
  const GroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: 300,
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              spacing: 10,
              children: [
                MyButton(
                  title: 'Criar grupo',
                  icon: Icons.create,
                  subTitle: Text(
                    'Crie um novo grupo do zero',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => context.push("/create_group"),
                ),
              ],
            ),
            Column(
              spacing: 10,
              children: [
                MyButton(
                  title: "Recuperar grupo",
                  icon: Icons.group,
                  subTitle: Text(
                    'Receba todos os grupos que você criou ou participa.',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => context.push("/enter_group"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
