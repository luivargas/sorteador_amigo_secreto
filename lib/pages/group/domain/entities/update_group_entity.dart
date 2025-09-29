// ignore_for_file: overridden_fields, annotate_overrides
import 'dart:ffi';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/participant_entity.dart';

class UpdateGroupEntity extends GroupEntity {
  final String code;
  final String shortCode;
  final String name;
  final String? drawDate;
  final String? location;
  final String? locale;
  final Float? minGiftValue;
  final Float? maxGiftValue;
  final String? coverImageUrl;
  final String? welcomeMessage;
  final bool? isGiftListPublic;
  final String? description;
  final String? raffledAt;
  final bool whatsappEnabled;
  final String? whatsappEnabledAt;
  final String status;
  final String token;
  final List<ParticipantEntity> participants;

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
