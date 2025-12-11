import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';

class GroupState {
  bool? isLoading;
  String? error;
  bool? created;
  bool? updated;
  bool? deleted;
  bool? archived;
  bool? unarchived;
  bool? showed;
  bool? raffled;
  ShowGroupModel? group;

  GroupState({
    this.showed,
    this.error,
    this.archived,
    this.created,
    this.deleted,
    this.isLoading,
    this.unarchived,
    this.group,
    this.updated,
    this.raffled,
  });

  GroupState copyWith({
    bool? isLoading,
    String? error,
    bool? created,
    bool? deleted,
    bool? archived,
    bool? unarchived,
    bool? showed,
    bool? updated,
    bool? raffled,
    ShowGroupModel? group,
  }) {
    return GroupState(
      archived: archived,
      created: created,
      deleted: deleted,
      isLoading: isLoading,
      unarchived: unarchived,
      showed: showed,
      group: group,
      updated: updated,
      raffled: raffled,
    );
  }
}
