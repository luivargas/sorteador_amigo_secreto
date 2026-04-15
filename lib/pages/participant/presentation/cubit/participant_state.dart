import 'package:equatable/equatable.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';

class ParticipantState extends Equatable {
  final bool isLoading;
  final bool created;
  final bool updated;
  final bool showed;
  final bool deleted;
  final AppError? error;
  final ShowParticipantModel? showParti;

  const ParticipantState({
    required this.isLoading,
    required this.created,
    required this.updated,
    required this.showed,
    this.error,
    this.showParti,
    required this.deleted,
  });

  factory ParticipantState.initial() {
    return const ParticipantState(
      isLoading: false,
      created: false,
      updated: false,
      showed: false,
      deleted: false,
    );
  }

  ParticipantState copyWith({
    bool? isLoading,
    bool? created,
    bool? updated,
    bool? showed,
    bool? deleted,
    AppError? error,
    ShowParticipantModel? showParti,
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
  ];
}
