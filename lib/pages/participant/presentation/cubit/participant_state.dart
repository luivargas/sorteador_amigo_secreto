import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';

class ParticipantState {
  bool? isLoading;
  String? error;
  bool? created;
  bool? deleted;
  bool? archived;
  bool? unarchived;
  bool? showed;

  ParticipantState({
    this.showed,
    this.error,
    this.archived,
    this.created,
    this.deleted,
    this.isLoading,
    this.unarchived,
  });

  ParticipantState copyWith({
    bool? isLoading,
    String? error,
    bool? created,
    bool? deleted,
    bool? archived,
    bool? unarchived,
    bool? showed,
    ShowGroupModel? group,
  }) {
    return ParticipantState(
      archived: archived,
      created: created,
      deleted: deleted,
      isLoading: isLoading,
      unarchived: unarchived,
      showed: showed,
    );
  }
}
