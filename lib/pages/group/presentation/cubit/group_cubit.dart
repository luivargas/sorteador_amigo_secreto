import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/usecases/group_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';

extension CubitExt<T> on Cubit<T> {
  void safeEmit(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}

class GroupCubit extends Cubit<GroupState> {
  final GroupUsecases groupUsecases;
  GroupCubit(this.groupUsecases) : super(GroupState());

  Future<void> create(CreateGroupEntity entity) async {
    if (isClosed) return;
    safeEmit(state.copyWith(isLoading: true, error: null));
    try {
      final result = await groupUsecases.create(entity);
      result.when(
        success: (s) => emit(state.copyWith(isLoading: false, created: true)),
        failure: (f) => emit(
          state.copyWith(
            isLoading: false,
            error: result.toString(),
            created: false,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> delete(int id) async {
    if (isClosed) return;
    safeEmit(state.copyWith(isLoading: true, error: null));
    try {
      await groupUsecases.delete(id);
      // fazer um ternario com retorno do result.
      emit(state.copyWith(isLoading: false, deleted: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> show(int id) async {
    safeEmit(state.copyWith(isLoading: true, error: null));
    try {
      final result = await groupUsecases.show(id);
      result.when(
        success: (s) =>
            emit(state.copyWith(isLoading: false, showed: true, group: s)),
        failure: (f) => emit(
          state.copyWith(
            isLoading: false,
            error: result.toString(),
            created: false,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(error: e.toString(), isLoading: false, showed: false),
      );
    }
  }

  Future<void> update(UpdateGroupEntity entity, int id) async {
    safeEmit(state.copyWith(isLoading: true, error: null, updated: false));
    try {
      final result = await groupUsecases.update(entity, id);
      result.when(
        success: (s) => emit(state.copyWith(isLoading: false, updated: true)),
        failure: (f) => emit(
          state.copyWith(
            isLoading: false,
            error: result.toString(),
            created: false,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(error: e.toString(), isLoading: false, showed: false),
      );
    }
  }

  Future<void> raffle(String code, int id) async {
    safeEmit(state.copyWith(isLoading: true, error: null, raffled: false));
    try {
      final result = await groupUsecases.raffle(code, id);
      result.when(success: (s) => emit(state.copyWith(isLoading: false, raffled: true)),
      failure: (f) => emit(state.copyWith(isLoading: false, error: result.toString(), raffled: false,),),
        
      );
    } catch (e) {
      state.copyWith(error: e.toString(), isLoading: false, raffled: false);
    }
  }
}
