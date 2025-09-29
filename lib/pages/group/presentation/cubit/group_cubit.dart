import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/error_api.dart';
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
      await groupUsecases.create(entity);
      emit(state.copyWith(isLoading: false, created: true));

    } on DioException catch (e) {
      final message = statusFallback(e.response?.statusCode);
      emit(state.copyWith(isLoading: false, error: message));
    } on HttpException catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Falha de conexão.'));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
