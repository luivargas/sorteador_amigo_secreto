import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/components/my_navbar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/forgot_password.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/create_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/screens/view_group.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/enter_group/enter_group.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/screens/home_screen.dart';
import 'package:sorteador_amigo_secreto/pages/auth/widgets/register.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/screens/auth.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/presentation/screens/splash_screen.dart';
import 'package:sorteador_amigo_secreto/pages/user/presentation/screens/user_screen.dart';

final auth = getIt<AuthCubit>();

final routes = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MyNavbar(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),

        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) => const Auth(),
        ),
      ],
    ),
    GoRoute(
      path: '/login_form',
      builder: (BuildContext context, GoRouterState state) => const Register(),
    ),
    GoRoute(
      path: '/user',
      builder: (BuildContext context, GoRouterState state) =>
          const UserScreen(),
    ),
    GoRoute(
      path: '/create_group',
      builder: (BuildContext context, GoRouterState state) =>
          const CreateGroup(),
    ),
    GoRoute(
      path: '/enter_group',
      builder: (BuildContext context, GoRouterState state) =>
          const EnterGroup(),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (BuildContext context, GoRouterState state) =>
          const ForgotPassword(),
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: '/view_group',
      builder: (BuildContext context, GoRouterState state) => const ViewGroup(),
    ),
  ],
);
