import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class ParticipantsListArgs {
  final List<ShowParticipantModel> participants;
  final String groupToken;
  final String groupCode;
  final BadgeType type;

  const ParticipantsListArgs({
    required this.participants,
    required this.groupToken,
    required this.groupCode,
    required this.type,
  });
}
