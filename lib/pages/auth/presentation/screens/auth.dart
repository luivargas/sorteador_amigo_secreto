import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';

import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/logged.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/login.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _Auth();
}

class _Auth extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocProvider.value(
        value: getIt<AuthCubit>(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            context.read<AuthCubit>();
            Widget screen = Container();
            final screenState = state.isLogged;
            if (screenState != true) {
              screen = LoginPage();
            } else {
              screen = LoggedPage();
            }
            return screen;
          },
        ),
      ),
    );
  }
}
