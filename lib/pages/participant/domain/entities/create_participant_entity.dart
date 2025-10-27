class CreateParticipantEntity {
  final String name;
  final String? email;
  final String? idd;
  final String? phone;
  final bool? isParticipant;
  final bool? isDependent;
  final String? role;
  final List<String>? wishList;
  final List<String>? preferences;
  final List<String>? size;
  final List<String>? dislike;
  final String? groupCode;

  CreateParticipantEntity({
    this.groupCode,
    required this.name,
    this.email,
    this.idd,
    this.phone,
    this.isParticipant,
    this.isDependent,
    this.role,
    this.wishList,
    this.preferences,
    this.size,
    this.dislike,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'idd': idd,
    'phone': phone,
    'is_participant': isParticipant,
    'is_dependent': isDependent,
    'role': role,
    'wish_list': wishList,
    'preferences': preferences,
    'size': size,
    'dislike': dislike,
    'group_code': groupCode,
    "status":"confirmed",
    "view_status":"not_viewed",
  };
}
