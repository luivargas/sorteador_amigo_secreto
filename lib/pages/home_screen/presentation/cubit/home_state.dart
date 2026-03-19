import 'package:equatable/equatable.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/isar_group_model.dart';

class HomeState extends Equatable {
  final List<IsarGroupModel> groups;
  final List<IsarGroupModel> filtered;
  final String search;
  final bool isLoading;
  final String? error;

  const HomeState({
    required this.groups,
    required this.filtered,
    required this.search,
    required this.isLoading,
    this.error,
  });

  factory HomeState.initial() {
    return const HomeState(
      groups: [],
      filtered: [],
      search: '',
      isLoading: true,
      error: null,
    );
  }

  HomeState copyWith({
    List<IsarGroupModel>? groups,
    List<IsarGroupModel>? filtered,
    String? search,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      groups: groups ?? this.groups,
      filtered: filtered ?? this.filtered,
      search: search ?? this.search,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        groups,
        filtered,
        search,
        isLoading,
        error,
      ];
}