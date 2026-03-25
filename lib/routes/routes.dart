import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_navbar.dart';
import 'package:sorteador_amigo_secreto/pages/auth/routes/auth_routes.dart';
import 'package:sorteador_amigo_secreto/pages/group/routes/group_routes.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/routes/home_routes.dart';
import 'package:sorteador_amigo_secreto/pages/participant/routes/participant_routes.dart';

final routes = GoRouter(
  initialLocation: '/splash',
  routes: [

    GoRoute(
      path: '/nav_bar',
      builder: (BuildContext context, GoRouterState state) => MyNavbar(),
    ),
    ...groupRoutes,
    ...participantRoutes,
    ...authRoutes,
    ...homeRoutes,
    
  ],
);
