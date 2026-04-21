import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/core/util/cubit_ext.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/device/device_info.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/validate_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/usecases/auth_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/usecases/group_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class GroupCubit extends Cubit<GroupState> {
  final GroupUsecases _groupUsecases;
  final AuthUsecases _authUsecases;
  final AuthDB _authDB;
  final DeviceData _deviceData;
  final GroupSession _groupSession;

  GroupCubit(
    this._groupUsecases,
    this._authUsecases,
    this._authDB,
    this._deviceData,
    this._groupSession,
  ) : super(GroupState.initial());

  void _emitFailure(AppError error) {
    safeEmit(
      state.copyWith(
        isLoading: false,
        error: error,
        logout: error == AppError.unauthorized,
      ),
    );
  }

    Future<bool> _validateSession() async {                                                                               
    final email = _authDB.email;                                                                                        
    final token = _authDB.token;
    if (email == null || token == null) {                                                                               
      _emitFailure(AppError.unauthorized);                                                                            
      return false;                                                                                                     
    }
                                                                                                                        
    final entity = ValidateToken(                                                                                     
      email: email,
      token: token,
      device: _deviceData.toDeviceString(),
    );

    try {
      final result = await _authUsecases.validate(entity);
      return result.when(                                                                                               
        success: (_) => true,
        failure: (f) {                                                                                                  
          _emitFailure(f.error);                                                                                      
          return false;
        },
      );
    } catch (e) {                                                                                                       
      _emitFailure(AppError.unknown);
      return false;                                                                                                     
    }                                                                                                                 
  }

  void loadGroups(List<AuthGroupModel> groups) {
    final filtered = _applyFilter(groups, state.search, state.filter);
    safeEmit(
      state.copyWith(groups: groups, filtered: filtered, isLoading: false),
    );
  }

  Future<void> refreshGroups() async {
    safeEmit(state.copyWith(isLoading: true, clearError: true, logout: false));

    final email = _authDB.email;
    final token = _authDB.token;
    if (email == null || token == null) {
      safeEmit(state.copyWith(isLoading: false, error: AppError.unauthorized));
      return;
    }

    final entity = ValidateToken(
      email: email,
      token: token,
      device: _deviceData.toDeviceString(),
    );

    try {
      final result = await _authUsecases.validate(entity);
      result.when(
        success: (groups) => loadGroups(groups),
        failure: (f) => _emitFailure(f.error)
      );
    } catch (e) {
      safeEmit(state.copyWith(isLoading: false, error: AppError.unknown));
    }
  }

  void onSearchChanged(String value) {
    final newSearch = value.trim();
    if (newSearch == state.search) return;
    final filtered = _applyFilter(state.groups, newSearch, state.filter);
    safeEmit(state.copyWith(search: newSearch, filtered: filtered));
  }

  void onFilterChanged(GroupFilter filter) {
    if (filter == state.filter) return;
    final filtered = _applyFilter(state.groups, state.search, filter);
    safeEmit(state.copyWith(filter: filter, filtered: filtered));
  }

  List<AuthGroupModel> _applyFilter(
    List<AuthGroupModel> list,
    String query,
    GroupFilter filter,
  ) {
    var result = list;
    if (filter == GroupFilter.raffled) {
      result = result.where((g) => g.isRaffled).toList();
    } else if (filter == GroupFilter.pending) {
      result = result.where((g) => !g.isRaffled).toList();
    }
    final q = query.toLowerCase();
    if (q.isNotEmpty) {
      result = result.where((g) => g.name.toLowerCase().contains(q)).toList();
    }
    return result;
  }

  Future<void> create(CreateGroupEntity entity) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true));
    if (!await _validateSession()) return;
    try {
      final result = await _groupUsecases.create(entity);
      result.when(
        success: (group) {
          _groupSession.setGroup(group);
          safeEmit(
            state.copyWith(
              isLoading: false,
              created: true,
              createdGroup: group,
            ),
          );
        },
        failure: (f) => _emitFailure(f.error)
      );
    } catch (e) {
      safeEmit(state.copyWith(error: AppError.unknown, isLoading: false));
    }
  }

  Future<void> delete(String code, String token) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true, deleted: false));
    if (!await _validateSession()) return;
    try {
      final result = await _groupUsecases.delete(code, token);
      result.when(
        success: (_) {
          final updated = state.groups.where((g) => g.code != code).toList();
          safeEmit(
            state.copyWith(isLoading: false, deleted: true, groups: updated),
          );
        },
        failure: (f) => _emitFailure(f.error),
      );
    } catch (e) {
      safeEmit(
        state.copyWith(
          error: AppError.unknown,
          isLoading: false,
          deleted: false,
        ),
      );
    }
  }

  Future<void> show(String code, String token) async {
    safeEmit(
      state.copyWith(isLoading: true, clearError: true, clearGroup: true),
    );
    if (!await _validateSession()) return;
    try {
      final result = await _groupUsecases.show(code, token);
      result.when(
        success: (s) {
          _groupSession.setGroup(s);
          safeEmit(state.copyWith(group: s, isLoading: false));
        },
        failure: (f) => _emitFailure(f.error)
      );
    } catch (e) {
      safeEmit(state.copyWith(error: AppError.unknown, isLoading: false));
    }
  }

  Future<void> update(
    UpdateGroupEntity entity,
    String code,
    String token,
  ) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true, updated: false));
    if (!await _validateSession()) return;
    try {
      final result = await _groupUsecases.update(entity, code, token);
      result.when(
        success: (s) =>
            safeEmit(state.copyWith(isLoading: false, updated: true)),
        failure: (f) => _emitFailure(f.error)
      );
    } catch (e) {
      safeEmit(state.copyWith(error: AppError.unknown, isLoading: false));
    }
  }

  Future<void> raffle(String code, String token) async {
    safeEmit(state.copyWith(isLoading: true, clearError: true, raffled: false));
    if (!await _validateSession()) return;
    try {
      final result = await _groupUsecases.raffle(code, token);
      result.when(
        success: (_) =>
            safeEmit(state.copyWith(raffled: true, isLoading: false)),
        failure: (f) => _emitFailure(f.error)
      );
    } catch (e) {
      safeEmit(
        state.copyWith(
          error: AppError.unknown,
          isLoading: false,
          raffled: false,
        ),
      );
    }
  }
}
