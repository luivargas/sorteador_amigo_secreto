import 'package:equatable/equatable.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';

class HomeState extends Equatable {
  final List<ShowGroupModel> groups;
  final List<ShowGroupModel> filtered;
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
      isLoading: false,
      error: null,
    );
  }

  HomeState copyWith({
    List<ShowGroupModel>? groups,
    List<ShowGroupModel>? filtered,
    String? search,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return HomeState(
      groups: groups ?? this.groups,
      filtered: filtered ?? this.filtered,
      search: search ?? this.search,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [groups, filtered, search, isLoading, error];
}
