import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class Access extends StatefulWidget {
  const Access({super.key});

  @override
  State<Access> createState() => _Access();
}

class _Access extends State<Access> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Theme.of(context).canvasColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20, top: 20),
        child: Column(
          spacing: 10,
          children: [
            Column(
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
                        TextSpan(
                          text: 'Sorteio Grátis ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(text: 'e Rápido!'),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    height: 35,
                    width: 215,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone_iphone, color: Colors.white,),
                        Text("Participe pelo WhatsApp!", style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 30),
              child: DefaultTextStyle.merge(
                textAlign: TextAlign.center,
                child: Text(
                  'Como funciona?',
                  style: myTheme.textTheme.titleMedium,
                ),
              ),
            ),
            DefaultTextStyle.merge(
              textAlign: TextAlign.center,
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: MyColors.sorteadorGradient,
                                borderRadius: BorderRadius.circular(90),
                              ),
                              width: 65,
                              height: 65,
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Crie um grupo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text("Defina nome, valor e regras do sorteio"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 10,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: MyColors.sorteadorGradient,
                                borderRadius: BorderRadius.circular(90),
                              ),
                              width: 65,
                              height: 65,
                              child: Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Adicione participantes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text("Defina nome, valor e regras do sorteio"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          spacing: 10,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: MyColors.sorteadorGradient,
                                borderRadius: BorderRadius.circular(90),
                              ),
                              width: 65,
                              height: 65,
                              child: Center(
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Realize o sorteio',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text("O sistema sorteia automaticamente"),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          spacing: 10,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: MyColors.sorteadorGradient,
                                borderRadius: BorderRadius.circular(90),
                              ),
                              width: 65,
                              height: 65,
                              child: Center(
                                child: Text(
                                  '4',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Receba os resultados',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Cada participante recebe seu amigo secreto por email ou whatsapp (plano Premium)",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
