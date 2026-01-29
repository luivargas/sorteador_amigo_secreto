
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';

class ParticipantState {
  bool? isLoading;
  String? error;
  bool? created;
  bool? deleted;
  bool? showed;
  bool? updated;
  ShowParticipantModel? showParti;

  ParticipantState({
    this.showed,
    this.error,
    this.created,
    this.deleted,
    this.isLoading,
    this.showParti,
    this.updated, 
  });

  ParticipantState copyWith({
    bool? isLoading,
    String? error,
    bool? created,
    bool? deleted,
    bool? showed,
    bool? updated,
    ShowParticipantModel? showParti,
  }) {
    return ParticipantState(
      error: error,
      created: created,
      deleted: deleted,
      isLoading: isLoading,
      showed: showed,
      updated: updated,
      showParti: showParti,
    );
  }
}
