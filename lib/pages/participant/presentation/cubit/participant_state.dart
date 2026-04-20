import 'package:equatable/equatable.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';

class ParticipantState extends Equatable {
  final bool isLoading;
  final bool created;
  final bool updated;
  final bool showed;
  final bool deleted;
  final bool resended;
  final AppError? error;
  final ParticipantModel? showParti;

  const ParticipantState({
    required this.isLoading,
    required this.created,
    required this.updated,
    required this.showed,
    this.error,
    this.showParti,
    required this.deleted,
    required this.resended,
  });

  factory ParticipantState.initial() {
    return const ParticipantState(
      isLoading: false,
      created: false,
      updated: false,
      showed: false,
      deleted: false,
      resended: false,
    );
  }

  ParticipantState copyWith({
    bool? isLoading,
    bool? created,
    bool? updated,
    bool? showed,
    bool? deleted,
    bool? resended,
    AppError? error,
    ParticipantModel? showParti,
    bool clearError = false,
    bool clearShowParti = false,
  }) {
    return ParticipantState(
      isLoading: isLoading ?? this.isLoading,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      showed: showed ?? this.showed,
      error: clearError ? null : (error ?? this.error),
      showParti: clearShowParti ? null : (showParti ?? this.showParti),
      deleted: deleted ?? this.deleted,
      resended: resended ?? this.resended,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    created,
    updated,
    showed,
    error,
    showParti,
    deleted,
    resended,
  ];
}
