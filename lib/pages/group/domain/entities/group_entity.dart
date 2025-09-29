import 'dart:ffi';

import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/participant_entity.dart';

class GroupEntity {
  final String? code;
  final String? shortCode;
  final String? name;
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
  final bool? whatsappEnabled;
  final String? whatsappEnabledAt;
  final String? status;
  final String? token;
  final List<ParticipantEntity>? participants;

  GroupEntity({
    this.code,
    this.shortCode,
    this.name,
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
    this.whatsappEnabled,
    this.whatsappEnabledAt,
    this.status,
    this.token,
    this.participants,
  });
}
