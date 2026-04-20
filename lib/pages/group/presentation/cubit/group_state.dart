import 'package:equatable/equatable.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/group_model.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class GroupState extends Equatable {
  final bool isLoading;
  final bool created;
  final bool updated;
  final bool deleted;
  final bool raffled;
  final AppError? error;
  final GroupModel? group;
  final GroupModel? createdGroup;
  final List<AuthGroupModel> groups;
  final List<AuthGroupModel> filtered;
  final String search;
  final GroupFilter filter;

  const GroupState({
    required this.isLoading,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.raffled,
    this.error,
    this.group,
    this.createdGroup,
    required this.groups,
    required this.filtered,
    required this.search,
    required this.filter,
  });

  factory GroupState.initial() {
    return const GroupState(
      isLoading: false,
      created: false,
      updated: false,
      deleted: false,
      raffled: false,
      groups: [],
      filtered: [],
      search: '',
      filter: GroupFilter.all,
    );
  }

  GroupState copyWith({
    bool? isLoading,
    bool? created,
    bool? updated,
    bool? deleted,
    bool? raffled,
    AppError? error,
    GroupModel? group,
    bool clearError = false,
    bool clearGroup = false,
    GroupModel? createdGroup,
    bool clearCreatedGroup = false,
    List<AuthGroupModel>? groups,
    List<AuthGroupModel>? filtered,
    String? search,
    GroupFilter? filter,
  }) {
    return GroupState(
      isLoading: isLoading ?? this.isLoading,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      deleted: deleted ?? this.deleted,
      raffled: raffled ?? this.raffled,
      error: clearError ? null : (error ?? this.error),
      group: clearGroup ? null : (group ?? this.group),
      createdGroup: clearCreatedGroup
          ? null
          : (createdGroup ?? this.createdGroup),
      groups: groups ?? this.groups,
      filtered: filtered ?? this.filtered,
      search: search ?? this.search,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    created,
    updated,
    deleted,
    raffled,
    error,
    group,
    createdGroup,
    groups,
    filtered,
    search,
    filter,
  ];
}
