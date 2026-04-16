import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';

class GroupSession {
  ShowGroupModel? _currentGroup;

  ShowGroupModel? get currentGroup => _currentGroup;

  void setGroup(ShowGroupModel group) {
    _currentGroup = group;
  }

  void clear() {
    _currentGroup = null;
  }

  bool get isRaffled => _currentGroup?.raffledAt != null;
  String get token => _currentGroup?.token ?? '';
  String get code => _currentGroup?.code ?? '';
  String get name => _currentGroup?.name ?? '';
  List<ShowParticipantModel> get participants =>
      _currentGroup?.participants ?? [];
}
