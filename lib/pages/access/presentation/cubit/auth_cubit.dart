import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/usecases/auth_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/error_api.dart';

extension CubitExt<T> on Cubit<T> {
  void safeEmit(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}

class AuthCubit extends Cubit<AuthState> {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  final AuthUsecases authUsecases;
  AuthCubit(this.authUsecases) : super(AuthState());

  Future<void> call() async {
    if (isClosed) return;
    safeEmit(state.copyWith(isLoading: true, error: null));
    try {
      final token = await asyncPrefs.containsKey('auth_token');
      if (token) {
        emit(state.copyWith(isLoading: false, isLogged: true));
      } else {
        emit(state.copyWith(isLoading: false, isLogged: false));
      }
    } on DioException catch (e) {
      final message = statusFallback(e.response?.statusCode);
      emit(state.copyWith(isLoading: false, error: message));
    } on HttpException catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Falha de conexão.'));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> register(entity) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await authUsecases.register(entity);
      emit(state.copyWith(isLoading: false, isRegister: true));
    } on DioException catch (e) {
      final message = statusFallback(e.response?.statusCode);
      emit(state.copyWith(isLoading: false, error: message));
    } on HttpException catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Falha de conexão.'));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> login(entity) async {
    if (isClosed) return;
    safeEmit(state.copyWith(isLoading: true, error: null));
    try {
      final result = await authUsecases.login(entity);
      await asyncPrefs.setString('auth_token', result.uuid);
      await asyncPrefs.setString('jwt', result.jwt);
      emit(state.copyWith(isLoading: false, isLogged: true));
    } on DioException catch (e) {
      final message = statusFallback(e.response?.statusCode);
      emit(state.copyWith(isLoading: false, error: message));
    } on HttpException catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Falha de conexão.'));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> logout(entity) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await authUsecases.logout(entity);
      await asyncPrefs.remove('auth_token');
      await asyncPrefs.remove('jwt');
      emit(state.copyWith(isLoading: false, isLogged: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> forgotPassword(entity) async {
    emit(state.copyWith(isLoading: true, error: null, resetPassword: false));
    try {
      await authUsecases.forgotPassword(entity);
      emit(state.copyWith(isLoading: false, resetPassword: true));
    } on DioException catch (e) {
      final message = statusFallback(e.response?.statusCode);
      emit(state.copyWith(isLoading: false, error: message));
    } on HttpException catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Falha de conexão.'));
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          error:
              'Não foi possível enviar o e-mail agora. Tente novamente mais tarde.',
        ),
      );
    }
  }
}
