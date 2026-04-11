import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_navbar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/request_token.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/splash_screen.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/validate_token_screen.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/cubit/home_cubit.dart';

CustomTransitionPage<void> _fadePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, _, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

List<RouteBase> authRoutes = [
  GoRoute(
    name: 'splash',
    path: '/splash',
    pageBuilder: (context, state) => _fadePage(
      state: state,
      child: BlocProvider(
        create: (_) {
          final cubit = getIt<AuthCubit>();
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => cubit.checkSession(),
          );
          return cubit;
        },
        child: SplashScreen(),
      ),
    ),
  ),
  GoRoute(
    name: 'request_token',
    path: '/request_token',
    pageBuilder: (context, state) => _fadePage(
      state: state,
      child: BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: RequestTokenScreen(),
      ),
    ),
  ),
  GoRoute(
    name: 'validate_token',
    path: '/validate_token',
    pageBuilder: (context, state) => _fadePage(
      state: state,
      child: BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: ValidateTokenScreen(email: state.extra as String),
      ),
    ),
  ),
  GoRoute(
    path: '/nav_bar',
    name: 'nav_bar',
    pageBuilder: (context, state) {
      final groups = (state.extra as List<AuthGroupModel>?) ?? [];
      return _fadePage(
        state: state,
        child: BlocProvider(
          create: (_) => getIt<HomeCubit>()..loadGroups(groups),
          child: MyNavbar(groups: groups),
        ),
      );
    },
  ),
];
