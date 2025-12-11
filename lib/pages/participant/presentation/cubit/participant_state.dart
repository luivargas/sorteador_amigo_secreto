
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';

class ParticipantState {
  bool? isLoading;
  String? error;
  bool? created;
  bool? deleted;
  bool? showed;
  ShowParticipantModel? participant;

  ParticipantState({
    this.showed,
    this.error,
    this.created,
    this.deleted,
    this.isLoading,
    this.participant,
  });

  ParticipantState copyWith({
    bool? isLoading,
    String? error,
    bool? created,
    bool? deleted,
    bool? showed,
    ShowParticipantModel? participant,
  }) {
    return ParticipantState(
      error: error,
      created: created,
      deleted: deleted,
      isLoading: isLoading,
      showed: showed,
      participant: participant
    );
  }
}
