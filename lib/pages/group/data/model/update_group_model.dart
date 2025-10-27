import 'package:sorteador_amigo_secreto/pages/participant/data/model/update_participant_model.dart';

class UpdateGroupModel {
  final String name;
  final String? drawDate;
  final String? location;
  final String? locale;
  final String? minGiftValue;
  final String? maxGiftValue;
  //final String? coverImageUrl;
  final String? welcomeMessage;
  final bool? isGiftListPublic;
  final String? description;
  final String? raffledAt;
  final bool? whatsappEnabled;
  final String? whatsappEnabledAt;
  final String? status;
  final List<UpdateParticipantModel> participants;

  UpdateGroupModel({
    this.drawDate,
    this.location,
    this.locale,
    this.minGiftValue,
    this.maxGiftValue,
    //this.coverImageUrl,
    this.welcomeMessage,
    this.isGiftListPublic,
    this.description,
    this.raffledAt,
    this.whatsappEnabledAt,
    required this.status,
    required this.name,
    this.whatsappEnabled,
    required this.participants,
  });

  factory UpdateGroupModel.fromJson(Map<String, dynamic> json) {
    List<UpdateParticipantModel> parseParticipants(List<dynamic> raw) {
      return raw
          .map((e) => UpdateParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return UpdateGroupModel(
      name: json['name'],
      drawDate: json['draw_date'],
      location: json['location'],
      locale: json['locale'],
      minGiftValue: json['min_gift_value'],
      maxGiftValue: json['max_gift_value'],
      //coverImageUrl: json['cover_image_url'],
      welcomeMessage: json['welcome_message'],
      isGiftListPublic: json['is_gift_list_public'],
      description: json['description'],
      raffledAt: json['raffled_at'],
      whatsappEnabled: json['whatsapp_enabled'],
      whatsappEnabledAt: json['whatsapp_enabled_at'],
      status: json['status'],
      participants: parseParticipants(json['participants'] as List<dynamic>),
    );
  }
}
