import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/components/my_navbar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/access/presentation/screens/access.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/forgot_password.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/create_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/edit_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/view_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/enter_group/enter_group.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/screens/home_screen.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/edit_paticipant.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/participant_form.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/teste.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/view_participant.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/presentation/screens/splash_screen.dart';

final routes = GoRouter(
  initialLocation: '/home',
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
      path: '/create_group',
      builder: (BuildContext context, GoRouterState state) => CreateGroup(),
    ),
    GoRoute(
      path: '/enter_group',
      builder: (BuildContext context, GoRouterState state) => EnterGroup(),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (BuildContext context, GoRouterState state) => ForgotPassword(),
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => SplashScreen(),
    ),
    GoRoute(
      name: 'view_group',
      path: '/view_group/:id',
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id'];
        final repo = getIt<GroupCubit>().groupUsecases;
        return BlocProvider(
          create: (_) => GroupCubit(repo)..show(int.parse(id!)),
          child: ViewGroup(groupId: id),
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
      name: 'create_part',
      path: '/create_part/:groupId/:groupCode',
      builder: (BuildContext context, GoRouterState state) {
        final groupId = state.pathParameters['groupId'];
        final groupCode = state.pathParameters['groupCode'];
        final repo = getIt<ParticipantCubit>().participantUsecase;
        return BlocProvider<ParticipantCubit>(
          create: (BuildContext context) => ParticipantCubit(repo),
          child: ParticipantForm(groupId: groupId, groupCode: groupCode),
        );
      },
    ),
    GoRoute(
      name: 'edit_group',
      path: '/edit_group/:id',
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id'];
        final repo = getIt<GroupCubit>().groupUsecases;
        return BlocProvider<GroupCubit>(
          create: (_) => GroupCubit(repo)..show(int.parse(id!)),
          child: EditGroup(groupId: id),
        );
      },
    ),
    GoRoute(
      name: 'edit_parti',
      path: '/edit_parti/:userId',
      builder: (BuildContext context, GoRouterState state) {
        final userId = state.pathParameters['userId'];
        final repo = getIt<ParticipantCubit>().participantUsecase;
        return BlocProvider<ParticipantCubit>(
          create: (_) => ParticipantCubit(repo)..show(userId!),
          child: EditPaticipant(userId: userId),
        );
      },
    ),
    GoRoute(
      name: 'view_parti',
      path: '/view_parti/:userId',
      builder: (BuildContext context, GoRouterState state) {
        final userId = state.pathParameters['userId'];
        final repo = getIt<ParticipantCubit>().participantUsecase;
        return BlocProvider<ParticipantCubit>(
          create: (_) => ParticipantCubit(repo)..show(userId!),
          child: ViewParticipant(userId: userId),
        );
      },
    ),
  ],
);
