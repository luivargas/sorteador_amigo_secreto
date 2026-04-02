import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class ParticipantsListArgs {
  final String groupToken;
  final String groupCode;
  final BadgeType type;

  const ParticipantsListArgs({
    required this.groupToken,
    required this.groupCode,
    required this.type,
  });
}
