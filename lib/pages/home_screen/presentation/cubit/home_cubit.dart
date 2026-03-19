import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/database/group_db.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/isar_group_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GroupDB _db;

  HomeCubit(this._db) : super(HomeState.initial());

  Future<void> loadGroups() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final groups = await _db.getAllGroups();
      final filtered = _applyFilter(groups, state.search);

      emit(state.copyWith(
        groups: groups,
        filtered: filtered,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void onSearchChanged(String value) {
    final newSearch = value.trim();

    if (newSearch == state.search) return;

    final filtered = _applyFilter(state.groups, newSearch);

    emit(state.copyWith(
      search: newSearch,
      filtered: filtered,
    ));
  }

  List<IsarGroupModel> _applyFilter(
    List<IsarGroupModel> list,
    String query,
  ) {
    final q = query.toLowerCase();

    if (q.isEmpty) return list;

    return list
        .where((g) => g.name.toLowerCase().contains(q))
        .toList();
  }
}