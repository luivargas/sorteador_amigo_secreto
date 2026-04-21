import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/contact_review_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/show_parti_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/contact_review.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/contacts_list.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/create_participant.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/all_participants_view.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/view_participant.dart';

List<RouteBase> participantRoutes = [
  GoRoute(
    name: 'contacts',
    path: '/contacts',
    builder: (BuildContext context, GoRouterState state) {
      return ContactList(
      );
    },
  ),
  GoRoute(
    name: 'create_part',
    path: '/create_part',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider<ParticipantCubit>(
        create: (_) => getIt<ParticipantCubit>(),
        child: CreateParticipant(
        ),
      );
    },
  ),
  GoRoute(
    name: 'view_parti',
    path: '/view_parti',
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as ShowParticipantArgs;
      final session = getIt<GroupSession>();
      return BlocProvider<ParticipantCubit>(
        create: (_) =>
            getIt<ParticipantCubit>()..show(extra.partId, session.token),
        child: ViewParticipant(userId: extra.partId),
      );
    },
  ),
  GoRoute(
    name: 'participants_list',
    path: '/participants_list',
    builder: (BuildContext context, GoRouterState state) {
      final session = getIt<GroupSession>();
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                getIt<GroupCubit>()..show(session.code, session.token),
          ),
          BlocProvider(create: (_) => getIt<ParticipantCubit>()),
        ],
        child: const AllParticipantsView(),
      );
    },
  ),
    GoRoute(                                                                                                              
    name: 'contact_review',                                                                                             
    path: '/contact_review',
    builder: (context, state) {                                                                                         
      final args = state.extra as ContactReviewArgs;                                                                  
      return ContactReviewScreen(args: args);
    },                                                                                                                  
  ),
];
