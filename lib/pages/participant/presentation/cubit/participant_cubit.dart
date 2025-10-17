import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
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
    safeEmit(state.copyWith(isLoading: true, error: null));
    try {
      final result = await participantUsecase.create(entity, id);
      // fazer um ternario com retorno do result.
      result.id.isNotEmpty
          ? emit(state.copyWith(isLoading: false, created: true))
          : emit(
              state.copyWith(
                isLoading: false,
                error: result.toString(),
                created: false,
              ),
            );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

}