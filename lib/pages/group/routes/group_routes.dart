import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/create_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/edit_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/view_group.dart';

List<RouteBase> groupRoutes = [
  GoRoute(
    name: 'create_group',
    path: '/create_group',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (_) => getIt<GroupCubit>(),
        child: CreateGroup(),
      );
    },
  ),
  GoRoute(
    name: 'view_group',
    path: '/view_group',
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as ShowGroupArgs;
      return BlocProvider(
        create: (_) => getIt<GroupCubit>()..show(extra.code, extra.token),
        child: ViewGroup(
          code: extra.code,
          token: extra.token,
          name: extra.name,
        ),
      );
    },
  ),
  GoRoute(
    name: 'edit_group',
    path: '/edit_group',
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as ShowGroupArgs;
      return BlocProvider<GroupCubit>(
        create: (_) => getIt<GroupCubit>()..show(extra.code, extra.token),
        child: EditGroup(),
      );
    },
  ),
];
