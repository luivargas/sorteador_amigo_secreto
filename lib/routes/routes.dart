
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/pages/auth/routes/auth_routes.dart';
import 'package:sorteador_amigo_secreto/pages/group/routes/group_routes.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/routes/home_routes.dart';
import 'package:sorteador_amigo_secreto/pages/participant/routes/participant_routes.dart';

final routes = GoRouter(
  initialLocation: '/splash',
  routes: [
    ...groupRoutes,
    ...participantRoutes,
    ...authRoutes,
    ...homeRoutes,
    
  ],
);
