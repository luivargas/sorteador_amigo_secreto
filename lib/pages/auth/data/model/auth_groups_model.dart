class AuthGroupModel {
  final String code;
  final String name;
  final String type;
  final String? status;
  final String token;
  final bool isRaffled;

  AuthGroupModel({
    this.status,
    required this.code,
    required this.name,
    required this.token,
    required this.type,
    required this.isRaffled,
  });

  factory AuthGroupModel.fromJson(Map<String, dynamic> json) {
    return AuthGroupModel(
      code: json['code'],
      name: json['name'],
      status: json['status'],
      token: json['access_key'],
      type: json['type'],
      isRaffled: json['is_raffled']
    );
  }
}
