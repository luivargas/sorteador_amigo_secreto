import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/request_token.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/splash_screen.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/validate_token_screen.dart';

List<RouteBase> authRoutes = [
  GoRoute(
    name: 'splash',
    path: '/splash',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (_) {
          final cubit = getIt<AuthCubit>();
          WidgetsBinding.instance.addPostFrameCallback((_) => cubit.checkSession());
          return cubit;
        },
        child: SplashScreen(),
      );
    },
  ),
  GoRoute(
    name: 'request_token',
    path: '/request_token',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: RequestTokenScreen(),
      );
    },
  ),
  GoRoute(
    name: 'validate_token',
    path: '/validate_token',
    builder: (BuildContext context, GoRouterState state) {
      final email = state.extra as String;
      return BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: ValidateTokenScreen(email: email),
      );
    },
  ),
];
