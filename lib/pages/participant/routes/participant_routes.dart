import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/create_parti_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/show_parti_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/participants_list_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/contacts_list.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/create_participant.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/all_participants_view.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/screens/view_participant.dart';

List<RouteBase> participantRoutes = [
  GoRoute(
    name: 'contacts',
    path: '/contacts',
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as CreateParticipantArgs;
      return ContactList(
        groupToken: extra.groupToken,
        groupCode: extra.groupCode,
      );
    },
  ),
  GoRoute(
    name: 'create_part',
    path: '/create_part',
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as CreateParticipantArgs;
      return BlocProvider<ParticipantCubit>(
        create: (_) => getIt<ParticipantCubit>(),
        child: CreateParticipant(
          groupToken: extra.groupToken,
          groupCode: extra.groupCode,
        ),
      );
    },
  ),
  GoRoute(
    name: 'view_parti',
    path: '/view_parti',
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as ShowParticipantArgs;
      return BlocProvider<ParticipantCubit>(
        create: (_) =>
            getIt<ParticipantCubit>()..show(extra.partId, extra.groupToken),
        child: ViewParticipant(
          userId: extra.partId,
          groupToken: extra.groupToken,
        ),
      );
    },
  ),
  GoRoute(
    name: 'participants_list',
    path: '/participants_list',
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as ParticipantsListArgs;
      return BlocProvider(
        create: (_) => getIt<GroupCubit>()..show(extra.groupCode, extra.groupToken),
        child: AllParticipantsView(
          groupToken: extra.groupToken,
          groupCode: extra.groupCode,
          type: extra.type,
        ),
      );
    },
  ),
];
