import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/device/device_info.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/validate_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/usecases/auth_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/usecases/group_usecases.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GroupUsecases _groupUsecases;
  final AuthUsecases _authUsecases;
  final AuthDB _authDB;
  final DeviceData _deviceData;

  HomeCubit(
    this._groupUsecases,
    this._authUsecases,
    this._authDB,
    this._deviceData,
  ) : super(HomeState.initial());

  void loadGroups(List<AuthGroupModel> groups) {
    final filtered = _applyFilter(groups, state.search);
    emit(state.copyWith(groups: groups, filtered: filtered, isLoading: false));
  }

  Future<void> refreshGroups() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final email = _authDB.email;
    final token = _authDB.token;
    if (email == null || token == null) {
      emit(state.copyWith(isLoading: false, error: 'sessionExpired'));
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
        failure: (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> deleteGroup(String token, String code) async {
    try {
      await _groupUsecases.delete(token);
      final updated = state.groups.where((g) => g.code != code).toList();
      final filtered = _applyFilter(updated, state.search);
      emit(state.copyWith(groups: updated, filtered: filtered));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void onSearchChanged(String value) {
    final newSearch = value.trim();
    if (newSearch == state.search) return;
    final filtered = _applyFilter(state.groups, newSearch);
    emit(state.copyWith(search: newSearch, filtered: filtered));
  }

  List<AuthGroupModel> _applyFilter(List<AuthGroupModel> list, String query) {
    final q = query.toLowerCase();
    if (q.isEmpty) return list;
    return list.where((g) => g.name.toLowerCase().contains(q)).toList();
  }
}
