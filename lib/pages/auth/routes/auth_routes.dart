import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/enter_group.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/splash_screen.dart';

List<RouteBase> authRoutes = [
  GoRoute(
    name: 'splash',
    path: '/splash',
    builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
  ),
  GoRoute(
    name: 'auth',
    path: '/auth',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: EnterGroup(),
      );
    },
  ),
];
