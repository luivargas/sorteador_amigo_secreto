class  ParticipantModel {
  final String id;
  final String name;
  final String email;
  final String? idd;
  final String? phone;
  final bool? isParticipant;
  final bool? isDependent;
  final String role;
  final String? viewStatus;
  final String? viewedAt;
  final String? whatsappSentAt;
  final String? giftPurchased;
  final String? status;
  final String? redrawVote;
  final List<dynamic>? wishList;
  final List<dynamic>? preferences;
  final List<dynamic>? size;
  final List<dynamic>? dislike;

  ParticipantModel({
    required this.id,
    required this.name,
    required this.email,
    this.idd,
    this.phone,
    this.isParticipant,
    this.isDependent,
    required this.role,
    this.viewStatus,
    this.viewedAt,
    this.whatsappSentAt,
    this.giftPurchased,
    this.status,
    this.redrawVote,
    this.wishList,
    this.preferences,
    this.size,
    this.dislike,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      idd: json['idd'],
      phone: json['phone'],
      isParticipant: json['is_participant'],
      isDependent: json['is_dependent'],
      role: json['role'],
      viewStatus: json['view_status'],
      viewedAt: json['viewed_at'],
      whatsappSentAt: json['whatsapp_sent_at'],
      giftPurchased: json['gift_purchased'],
      status: json['status'],
      redrawVote: json['redraw_vote'],
      wishList: json['wishlist'],
      preferences: json['preferences'],
      size: json['size'],
      dislike: json['dislike'],
    );
  }
}