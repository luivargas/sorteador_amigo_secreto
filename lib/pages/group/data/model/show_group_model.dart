import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';

class ShowGroupModel {
  final String code;
  final int shortCode;
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
  final bool? whatsappEnabled;
  final String? whatsappEnabledAt;
  final String? status;
  final String? token;
  final List<ShowParticipantModel>? participants;

  ShowGroupModel({
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
    this.whatsappEnabledAt,
    this.status,
    required this.code,
    required this.shortCode,
    required this.name,
    this.whatsappEnabled,
    required this.token,
    this.participants,
  });

  factory ShowGroupModel.fromJson(Map<String, dynamic> json) {
    List<ShowParticipantModel> parseParticipants(List<dynamic> raw) {
      return raw
          .map((e) => ShowParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return ShowGroupModel(
      code: json['code'],
      shortCode: json['short_code'],
      name: json['name'],
      drawDate: json['draw_date'],
      location: json['location'],
      locale: json['locale'],
      minGiftValue: json['min_gift_value'],
      maxGiftValue: json['max_gift_value'],
      coverImageUrl: json['cover_image_url'],
      welcomeMessage: json['welcome_message'],
      isGiftListPublic: json['is_gift_list_public'],
      description: json['description'],
      raffledAt: json['raffled_at'],
      whatsappEnabled: json['whatsapp_enabled'],
      whatsappEnabledAt: json['whatsapp_enabled_at'],
      status: json['status'],
      token: json['token'],
      participants: parseParticipants(json['participants'] as List<dynamic>),
    );
  }

}
