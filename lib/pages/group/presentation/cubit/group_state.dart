import 'package:equatable/equatable.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';

class GroupState extends Equatable {
  final bool isLoading;
  final bool created;
  final bool updated;
  final bool deleted;
  final bool raffled;
  final AppError? error;
  final ShowGroupModel? group;

  const GroupState({
    required this.isLoading,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.raffled,
    this.error,
    this.group,
  });

  factory GroupState.initial() {
    return const GroupState(
      isLoading: false,
      created: false,
      updated: false,
      deleted: false,
      raffled: false,
    );
  }

  GroupState copyWith({
    bool? isLoading,
    bool? created,
    bool? updated,
    bool? deleted,
    bool? raffled,
    AppError? error,
    ShowGroupModel? group,
    bool clearError = false,
    bool clearGroup = false,
  }) {
    return GroupState(
      isLoading: isLoading ?? this.isLoading,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      deleted: deleted ?? this.deleted,
      raffled: raffled ?? this.raffled,
      error: clearError ? null : (error ?? this.error),
      group: clearGroup ? null : (group ?? this.group),
    );
  }

  @override
  List<Object?> get props => [isLoading, created, updated, deleted, raffled, error, group];
}
