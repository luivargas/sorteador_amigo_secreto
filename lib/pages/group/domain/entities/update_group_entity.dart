import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';

class UpdateGroupEntity {
  final String code;
  final String shortCode;
  final String name;
  final String? drawDate;
  final String? location;
  final String? locale;
  final double? minGiftValue;
  final double? maxGiftValue;
  final String? coverImageUrl;
  final String? welcomeMessage;
  final bool? isGiftListPublic;
  final String? description;
  final String? raffledAt;
  final bool whatsappEnabled;
  final String? whatsappEnabledAt;
  final String status;
  final String token;
  final List<UpdateParticipantEntity> participants;

  UpdateGroupEntity({
    required this.code,
    required this.shortCode,
    required this.name,
    this.drawDate,
    this.location,
    this.locale,
    this.minGiftValue,
    this.maxGiftValue,
    this.coverImageUrl,
    this.welcomeMessage,
    this.isGiftListPublic,
    this.description,
    this.raffledAt,
    required this.whatsappEnabled,
    this.whatsappEnabledAt,
    required this.status,
    required this.token,
    required this.participants,
  });

    Map<String, dynamic> toJson() {
    return {
      "code": code,
      "short_code": shortCode,
      "name": name,
      "participants": participants,

    };
  }
}
