import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_navbar.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/auth/routes/auth_routes.dart';
import 'package:sorteador_amigo_secreto/pages/group/routes/group_routes.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/routes/home_routes.dart';
import 'package:sorteador_amigo_secreto/pages/participant/routes/participant_routes.dart';

final routes = GoRouter(
  initialLocation: '/splash',
  routes: [

    GoRoute(
      path: '/nav_bar',
      name: 'nav_bar',
      pageBuilder: (context, state) {
        final groups = (state.extra as List<AuthGroupModel>?) ?? [];
        return CustomTransitionPage(
          key: state.pageKey,
          child: MyNavbar(groups: groups),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (context, animation, _, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      },
    ),
    ...groupRoutes,
    ...participantRoutes,
    ...authRoutes,
    ...homeRoutes,
    
  ],
);
