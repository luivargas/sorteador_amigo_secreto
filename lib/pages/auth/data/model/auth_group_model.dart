class AuthGroupModel {
  final String? code;
  final String name;
  final String type;
  final String? status;
  final String token;

  AuthGroupModel({
    this.status,
    required this.code,
    required this.name,
    required this.token,
    required this.type,
  });

  factory AuthGroupModel.fromJson(Map<String, dynamic> json) {
    return AuthGroupModel(
      code: json['code'],
      name: json['name'],
      status: json['status'],
      token: json['token'],
      type: json['type'],
    );
  }
}
