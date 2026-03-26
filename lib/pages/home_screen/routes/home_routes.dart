import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/screens/home_screen.dart';

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

List<RouteBase> homeRoutes = [
  GoRoute(
    path: '/home',
    pageBuilder: (context, state) => _fadePage(
      state: state,
      child: HomeScreen(groups: (state.extra as List<AuthGroupModel>?) ?? []),
    ),
  ),
];
