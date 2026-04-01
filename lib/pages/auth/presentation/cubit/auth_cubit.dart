import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/core/util/cubit_ext.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/device/device_info.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/request_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/validate_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/usecases/auth_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecases authUsecases;
  final AuthDB authDB;
  final DeviceData deviceData;

  AuthCubit(this.authUsecases, this.authDB, this.deviceData)
      : super(AuthState.initial());

  Future<void> checkSession() async {
    safeEmit(state.copyWith(isLoading: true, clearError: true));
    await Future.delayed(const Duration(seconds: 2));

    if (!authDB.isAuthenticated) {
      safeEmit(state.copyWith(isLoading: false, sessionChecked: true));
      return;
    }

    final entity = ValidateToken(
      email: authDB.email!,
      token: authDB.token!,
      device: deviceData.toDeviceString(),
    );

    try {
      final result = await authUsecases.validate(entity);
      result.when(
        success: (model) => safeEmit(
          state.copyWith(
            isLoading: false,
            validated: true,
            groups: model,
            sessionChecked: true,
          ),
        ),
        failure: (f) => safeEmit(
          state.copyWith(
            isLoading: false,
            error: f.error,
            sessionChecked: true,
          ),
        ),
      );
    } catch (e) {
      safeEmit(
        state.copyWith(isLoading: false, error: AppError.unknow, sessionChecked: true),
      );
    }
  }

  Future<void> request(RequestToken entity) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true));
    try {
      final result = await authUsecases.request(entity);
      result.when(
        success: (_) async {
          await authDB.saveEmail(entity.email);
          await authDB.saveDevice(deviceData);
          safeEmit(state.copyWith(isLoading: false, requested: true));
        },
        failure: (f) => safeEmit(
          state.copyWith(isLoading: false, error: f.error, clearGroups: true),
        ),
      );
    } catch (e) {
      safeEmit(state.copyWith(error: AppError.unknow, isLoading: false));
    }
  }

  Future<void> validateToken(String token) async {
    final email = authDB.email;
    if (email == null) {
      safeEmit(state.copyWith(error: AppError.unauthorized, isLoading: false));
      return;
    }

    final entity = ValidateToken(
      email: email,
      token: token,
      device: deviceData.toDeviceString(),
    );

    safeEmit(state.copyWith(isLoading: true, clearError: true, clearGroups: true));
    try {
      final result = await authUsecases.validate(entity);
      result.when(
        success: (model) async {
          await authDB.saveToken(token);
          safeEmit(state.copyWith(isLoading: false, validated: true, groups: model));
        },
        failure: (f) => safeEmit(
          state.copyWith(isLoading: false, error: f.error, validated: false),
        ),
      );
    } catch (e) {
      safeEmit(state.copyWith(error: AppError.unknow, isLoading: false));
    }
  }
}
