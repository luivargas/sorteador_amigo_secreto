import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/screens/home_screen.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/screens/logout_screen.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/screens/onboarding.dart';

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

List<RouteBase> navRoutes = [
  GoRoute(
    path: '/home',
    pageBuilder: (context, state) => _fadePage(
      state: state,
      child: HomeScreen(groups: (state.extra as List<AuthGroupModel>?) ?? []),
    ),
  ),
  GoRoute(
    path: '/onboarding',
    name: 'onboarding',
    pageBuilder: (context, state) =>
        _fadePage(state: state, child: Onboarding()),
  ),
    GoRoute(
    path: '/logout',
    name: 'logout',
    pageBuilder: (context, state) =>
        _fadePage(state: state, child: LogoutScreen()),
  ),
];
