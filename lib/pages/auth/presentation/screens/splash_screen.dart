import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/network/contants.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) => !p.sessionChecked && c.sessionChecked,
      listener: (context, state) {
        if (state.validated) {
          context.goNamed('nav_bar');
        }
        if (!state.validated) {
          context.goNamed('request_token');
        }
      },
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Theme.of(context).canvasColor,
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset(iconLogo, scale: 15)),
                  CircularProgressIndicator(
                    color: MyColors.sorteadorOrange,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
