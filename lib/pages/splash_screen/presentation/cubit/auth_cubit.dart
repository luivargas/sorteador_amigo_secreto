import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/status_group_api.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_login_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_logout_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_register_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/usecases/auth_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/presentation/cubit/auth_state.dart';


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

  Future<void> register(AuthRegisterEntity entity) async {
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

  Future<void> login(AuthLoginEntity entity) async {
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

  Future<void> logout(AuthLogoutEntity entity) async {
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
}
