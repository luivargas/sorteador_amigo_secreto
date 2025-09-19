import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocProvider.value(
        value: getIt<AuthCubit>()..call(),
        child: SafeArea(
          child: Center(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("./assets/logos/full/Logo_3.png", scale: 15),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state.isLoading == false || state.isLogged != null) {
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        if (context.mounted) {
                          context.go('/home');
                        }
                      });
                    }
                  },
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
