import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class Identify extends StatefulWidget {
  const Identify({super.key});

  @override
  State<Identify> createState() => _Identify();
}

class _Identify extends State<Identify> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Theme.of(context).canvasColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 0),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Crie seu Grupo', style: myTheme.textTheme.titleSmall),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Escolha um nome maneiro',
                prefixIcon: Icon(Icons.abc),
                border: OutlineInputBorder(),
              ),
            ),
            
            MyButton(onTap: () {}, title: "Enviar", icon: Icons.send),
          ],
        ),
      ),
    );
  }
}
