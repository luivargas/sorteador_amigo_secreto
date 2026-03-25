import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>()..checkSession(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, current) => current.sessionChecked,
      listener: (context, state) {
        if (state.validated) {
          context.go('/nav_bar');
        } else {
          context.go('/auth');
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Logo / ícone do app
                Icon(
                  Icons.card_giftcard,
                  size: 80,
                  color: MyColors.sorteadorOrange,
                ),
                const SizedBox(height: 32),
                // Barra de progresso visível enquanto a API responde
                if (state.isLoading)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: LinearProgressIndicator(
                      color: MyColors.sorteadorOrange,
                      backgroundColor: MyColors.sorteadorOrange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }
}
