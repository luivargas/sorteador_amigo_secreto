import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
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
      // fazer um ternario com retorno do result.
      result.code.isNotEmpty
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
      // fazer um ternario com retorno do result.
      if (result.code.isNotEmpty) {
        emit(state.copyWith(isLoading: false, showed: true));
      }
      emit(state.copyWith(isLoading: false, showed: false));
      throw result.toString();
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
