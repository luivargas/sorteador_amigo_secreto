import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class Access extends StatefulWidget {
  const Access({super.key});

  @override
  State<Access> createState() => _Access();
}

class _Access extends State<Access> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20),
          child: Column(
            spacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      './assets/logos/full/logo_amigo_secreto.png',
                      scale: 5,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 10,
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return MyColors.sorteadorGradient.createShader(bounds);
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 30,
                            color: MyColors.sorteadorGrey,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(text: 'Amigo Secreto Online: '),
                            TextSpan(
                              text: 'Sorteio Grátis ',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(text: 'e Rápido!'),
                          ],
                        ),
                      ),
                    ),
                    Row(children: [Icon(Icons.phone_iphone), Text("Participe pelo WhatsApp!")],)
                  ],
                ),
              ),
              TextButton.icon(onPressed: () {
              }, label: Text("Recupere seus grupos facilmente")),
              MyButton(
                onTap: () => context.push("/create_group"),
                title: "Criar grupo",
                icon: Icons.create,
                subTitle: Text(
                  "Crie seu grupo de amigo secreto em segundos!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
