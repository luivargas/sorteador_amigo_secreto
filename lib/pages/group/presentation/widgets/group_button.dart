import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

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
                InkWell(
                  onTap: () => context.push('/create_group'),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.sorteadorOrange,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.create, color: Colors.white),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Criar grupo',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Crie um novo grupo do zero',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              spacing: 10,
              children: [
                InkWell(
                  onTap: () => context.push('/enter_group'),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.sorteadorOrange,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.group, color: Colors.white),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Entrar em grupo',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Entrar em um grupo que ja foi criado',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
