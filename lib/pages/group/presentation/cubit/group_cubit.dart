import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/core/util/cubit_ext.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/usecases/group_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GroupUsecases groupUsecases;
  GroupCubit(this.groupUsecases) : super(GroupState.initial());

  Future<void> create(CreateGroupEntity entity) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true));
    try {
      final result = await groupUsecases.create(entity);
      result.when(
        success: (_) => emit(state.copyWith(isLoading: false, created: true)),
        failure: (f) => emit(
          state.copyWith(isLoading: false, error: f.message, created: false),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> delete(String token) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true));
    try {
      await groupUsecases.delete(token);
      emit(state.copyWith(isLoading: false, deleted: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> show(String code, String token) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true, clearGroup: true));
    try {
      final result = await groupUsecases.show(code, token);
      result.when(
        success: (s) => emit(state.copyWith(group: s, isLoading: false)),
        failure: (f) => emit(
          state.copyWith(isLoading: false, error: f.message, clearGroup: true),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> update(UpdateGroupEntity entity, String code, String token) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true, updated: false));
    try {
      final result = await groupUsecases.update(entity, code, token);
      result.when(
        success: (_) => emit(state.copyWith(isLoading: false, updated: true)),
        failure: (f) => emit(
          state.copyWith(isLoading: false, error: f.message, updated: false),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> raffle(String code, String token) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true, raffled: false));
    try {
      final result = await groupUsecases.raffle(code, token);
      result.when(
        success: (_) => emit(state.copyWith(raffled: true, isLoading: false)),
        failure: (f) => emit(
          state.copyWith(isLoading: false, error: f.message, raffled: false),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false, raffled: false));
    }
  }
}
