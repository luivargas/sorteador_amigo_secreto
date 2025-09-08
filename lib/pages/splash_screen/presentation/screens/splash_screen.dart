import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

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
      backgroundColor: MyColors.sorteadorOrange,
      body: BlocProvider.value(
        value: getIt<AuthCubit>()..call(),
        child: SafeArea(
          child: Center(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("./assets/logos/icons/Logo_8.png", scale: 20),
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
