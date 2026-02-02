import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_navbar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/test2.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/presentation/screens/access.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/create_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/edit_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/view_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/enter_group/enter_group.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/screens/home_screen.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/create_parti_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/show_parti_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/create_participant.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/teste.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/view_participant.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/presentation/screens/splash_screen.dart';

final routes = GoRouter(
  initialLocation: '/test',
  routes: [
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) => HomeScreen(),
    ),
    GoRoute(
      path: '/access',
      builder: (BuildContext context, GoRouterState state) => Access(),
    ),
    GoRoute(
      name: 'create_group',
      path: '/create_group',
      builder: (BuildContext context, GoRouterState state) {
        final repo = getIt<GroupCubit>().groupUsecases;
        return BlocProvider<GroupCubit>(
          create: (BuildContext context) => GroupCubit(repo),
          child:  CreateGroup(),
        );
      },
    ),
    GoRoute(
      path: '/enter_group',
      builder: (BuildContext context, GoRouterState state) => EnterGroup(),
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => SplashScreen(),
    ),
    GoRoute(
      name: 'view_group',
      path: '/view_group',
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as ShowGroupArgs;
        final repo = getIt<GroupCubit>().groupUsecases;
        return BlocProvider(
          create: (_) => GroupCubit(repo)..show(extra.groupId),
          child: ViewGroup(groupId: extra.groupId),
        );
      },
    ),
    GoRoute(
      path: '/nav_bar',
      builder: (BuildContext context, GoRouterState state) => MyNavbar(),
    ),
    GoRoute(
      path: '/test',
      builder: (BuildContext context, GoRouterState state) =>
          FlutterContactsExample(),
    ),
        GoRoute(
      path: '/test2',
      builder: (BuildContext context, GoRouterState state) =>
          Teste2(),
    ),
        GoRoute(
      name: 'edit_group',
      path: '/edit_group',
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as ShowGroupArgs;
        final repo = getIt<GroupCubit>().groupUsecases;
        return BlocProvider<GroupCubit>(
          create: (_) => GroupCubit(repo)..show(extra.groupId),
          child: EditGroup(groupId: extra.groupId),
        );
      },
    ),
    GoRoute(
      name: 'create_part',
      path: '/create_part',
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as CreateParticipantArgs;
        final repo = getIt<ParticipantCubit>().participantUsecase;
        return BlocProvider<ParticipantCubit>(
          create: (_) => ParticipantCubit(repo),
          child: CreateParticipant(groupId: extra.groupId, groupCode: extra.groupCode),
        );
      },
    ),
    GoRoute(
      name: 'view_parti',
      path: '/view_parti',
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as ShowParticipantArgs;
        final repo = getIt<ParticipantCubit>().participantUsecase;
        return BlocProvider<ParticipantCubit>(
          create: (_) => ParticipantCubit(repo)..show(extra.userId, extra.groupToken),
          child: ViewParticipant(userId: extra.userId, groupToken: extra.groupToken),
        );
      },
    ),
  ],
);
