import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';

class CreateGroupEntity {
  final String name;
  final String? drawDate;
  final String? location;
  final double? minGiftValue;
  final double? maxGiftValue;
  final String? coverImageUrl;
  final String? welcomeMessage;
  final bool? isGiftListPublic;
  final String? description;
  final CreateParticipantEntity admin;

  CreateGroupEntity({
    required this.name,
    required this.admin,
    this.drawDate,
    this.location,
    this.minGiftValue,
    this.maxGiftValue,
    this.coverImageUrl,
    this.welcomeMessage,
    this.isGiftListPublic,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
    "name": name,
    "draw_date": drawDate,
    "location": location,
    "description": description,
    "min_gift_value": minGiftValue,
    "max_gift_value": maxGiftValue,
      "admin": {
        "name": admin.name,
        "email": admin.email,
        "idd": admin.idd,
        "phone": admin.phone,
      },
    };
  }
}
