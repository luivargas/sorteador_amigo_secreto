import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/core/util/cubit_ext.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/usecases/participant_usecase.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';

class ParticipantCubit extends Cubit<ParticipantState> {
  final ParticipantUsecase participantUsecase;
  ParticipantCubit(this.participantUsecase) : super(ParticipantState.initial());

  Future<void> create(CreateParticipantEntity entity, String groupToken) async {
    if (isClosed) return;
    safeEmit(state.copyWith(isLoading: true, clearError: true, created: false));
    try {
      final result = await participantUsecase.create(entity, groupToken);
      result.when(
        success: (_) => emit(state.copyWith(isLoading: false, created: true)),
        failure: (f) => emit(
          state.copyWith(isLoading: false, error: f.message, created: false),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false, created: false));
    }
  }

  Future<void> show(String id, String groupToken) async {
    if (isClosed) return;
    safeEmit(state.copyWith(isLoading: true, clearError: true, showed: false));
    try {
      final result = await participantUsecase.show(id, groupToken);
      result.when(
        success: (s) =>
            emit(state.copyWith(isLoading: false, showed: true, showParti: s)),
        failure: (f) => emit(
          state.copyWith(isLoading: false, error: f.message, showed: false),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false, showed: false));
    }
  }

  Future<void> update(
    UpdateParticipantEntity entity,
    String id,
    String groupToken,
  ) async {
    if (isClosed) return;
    safeEmit(state.copyWith(isLoading: true, clearError: true, updated: false));
    try {
      final result = await participantUsecase.update(entity, id, groupToken);
      result.when(
        success: (_) => emit(state.copyWith(isLoading: false, updated: true)),
        failure: (f) => emit(
          state.copyWith(isLoading: false, error: f.message, updated: false),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false, updated: false));
    }
  }
}
