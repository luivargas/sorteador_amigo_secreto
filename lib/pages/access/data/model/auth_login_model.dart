class AuthLoginModel {
  final String jwt;
  final String uuid;
  final String firstName;
  final String lastName;
  final String email;

  AuthLoginModel({
    required this.uuid,
    required this.jwt,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory AuthLoginModel.fromJson(Map<String, dynamic> json) {
    return AuthLoginModel(
      uuid: json['uuid'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      jwt: json['jwt'],
    );
  }
}
