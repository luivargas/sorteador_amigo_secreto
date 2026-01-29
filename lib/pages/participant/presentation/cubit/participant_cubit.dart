import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/usecases/participant_usecase.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';

extension CubitExt<T> on Cubit<T> {
  void safeEmit(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}

class ParticipantCubit extends Cubit<ParticipantState> {
  final ParticipantUsecase participantUsecase;
  ParticipantCubit(this.participantUsecase) : super(ParticipantState());

  Future<void> create(CreateParticipantEntity entity, id) async {
    if (isClosed) return;
    safeEmit(state.copyWith(isLoading: true, error: null, created: false));
    try {
      final result = await participantUsecase.create(entity, id);
      result.when(
        success: (s) => emit(state.copyWith(isLoading: false, created: true)),
        failure: (f) => emit(
          state.copyWith(isLoading: false, error: f.message, created: false),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(error: e.toString(), isLoading: false, created: false),
      );
    }
  }

  Future<void> show(String id, String groupToken) async {
    if (isClosed) return;
    safeEmit(
      state.copyWith(
        isLoading: true,
        error: null,
        showed: false,
      ),
    );
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
      emit(
        state.copyWith(error: e.toString(), isLoading: false, showed: false),
      );
    }
  }

  Future<void> update(
    UpdateParticipantEntity entity,
    String id,
    String groupToken,
  ) async {
    if (isClosed) return;
    safeEmit(
      state.copyWith(
        isLoading: true,
        error: null,
        updated: false,
      ),
    );
    try {
      final result = await participantUsecase.update(entity, id, groupToken);
      result.when(
        success: (s) => emit(
          state.copyWith(isLoading: false, updated: true,),
        ),
        failure: (f) => emit(
          state.copyWith(isLoading: false, error: f.message, updated: false),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(error: e.toString(), isLoading: false, updated: false),
      );
    }
  }
}
