import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/screens/home_screen.dart';

List<RouteBase> homeRoutes = [
  GoRoute(
    path: '/home',
    builder: (BuildContext context, GoRouterState state) {
      final groups = (state.extra as List<ShowGroupModel>?) ?? [];
      return HomeScreen(groups: groups);
    },
  ),
];
