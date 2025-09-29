import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/participant_entity.dart';

class CreateGroupEntity {
  final String name;
  final ParticipantEntity admin;

  CreateGroupEntity({required this.name, required this.admin});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "admin": {"name": admin.name, "email": admin.email},
    };
  }
}
