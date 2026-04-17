import 'package:sorteador_amigo_secreto/pages/group/data/model/group_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';

class GroupSession {
  GroupModel? _currentGroup;

  GroupModel? get currentGroup => _currentGroup;

  void setGroup(GroupModel group) {
    _currentGroup = group;
  }

  void clear() {
    _currentGroup = null;
  }

  bool get isRaffled => _currentGroup?.raffledAt != null;
  String get token => _currentGroup?.token ?? '';
  String get code => _currentGroup?.code ?? '';
  String get name => _currentGroup?.name ?? '';
  List<ParticipantModel> get participants =>
      _currentGroup?.participants ?? [];
}
