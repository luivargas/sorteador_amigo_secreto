class ShowParticipantEntity {
  final String? id;
  final String? name;
  final String? email;
  final String? idd;
  final String? phone;
  final bool? isParticipant;
  final bool? isDependent;
  final String? role;
  final String? viewStatus;
  final String? viewedAt;
  final String? whatsappSentAt;
  final String? giftPurchased;
  final String? status;
  final String? redrawVote;
  final List<String>? wishList;
  final List<String>? preferences;
  final List<String>? size;
  final List<String>? dislike;

  ShowParticipantEntity({
    this.id,
    this.name,
    this.email,
    this.idd,
    this.phone,
    this.isParticipant,
    this.isDependent,
    this.role,
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'idd': idd,
    'phone': phone,
    'is_participant': isParticipant,
    'is_dependent': isDependent,
    'role': role,
    'view_status': viewStatus,
    'viewed_at': viewedAt,
    'whatsapp_sent_at': whatsappSentAt,
    'gift_purchased': giftPurchased,
    'status': status,
    'redraw_vote': redrawVote,
    'wish_list': wishList,
    'preferences': preferences,
    'size': size,
    'dislike': dislike,
  };
}
