import 'package:equatable/equatable.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';

enum GroupFilter { all, pending, raffled }

class HomeState extends Equatable {
  final List<AuthGroupModel> groups;
  final List<AuthGroupModel> filtered;
  final String search;
  final GroupFilter filter;
  final bool isLoading;
  final AppError? error;

  const HomeState({
    required this.groups,
    required this.filtered,
    required this.search,
    required this.filter,
    required this.isLoading,
    this.error,
  });

  factory HomeState.initial() {
    return const HomeState(
      groups: [],
      filtered: [],
      search: '',
      filter: GroupFilter.all,
      isLoading: false,
      error: null,
    );
  }

  HomeState copyWith({
    List<AuthGroupModel>? groups,
    List<AuthGroupModel>? filtered,
    String? search,
    GroupFilter? filter,
    bool? isLoading,
    AppError? error,
    bool clearError = false,
  }) {
    return HomeState(
      groups: groups ?? this.groups,
      filtered: filtered ?? this.filtered,
      search: search ?? this.search,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [groups, filtered, search, filter, isLoading, error];
}
