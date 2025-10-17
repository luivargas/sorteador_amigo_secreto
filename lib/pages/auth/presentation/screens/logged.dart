import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/auth_logout_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';

class LoggedPage extends StatefulWidget {
  const LoggedPage({super.key});

  @override
  State<LoggedPage> createState() => _LoggedPage();
}

class _LoggedPage extends State<LoggedPage> {
  Future<void> _onSubmit() async {
    final email = "luiz@luizvargas.net";
    final password = "luiz12345";
    final entity = AuthLogoutEntity(email: email, password: password);
    getIt<AuthCubit>().logout(entity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 300,
          maxWidth: 600,
          minHeight: 400,
          maxHeight: 800,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("./assets/logos/icons/Logo_9.png", scale: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Ver perfil'),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            _onSubmit();
                          },
                          child: Text('Sair'),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child: Text('Excluir conta')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
