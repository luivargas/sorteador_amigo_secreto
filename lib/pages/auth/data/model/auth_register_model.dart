class AuthRegisterModel {
  final String jwt;
  final String uuid;
  final String firstName;
  final String lastName;
  final String email;

  AuthRegisterModel({
    required this.uuid,
    required this.jwt,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory AuthRegisterModel.fromJson(Map<String, dynamic> json) {
    return AuthRegisterModel(
      uuid: json['uuid'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      jwt: json['jwt'],
    );
  }
}
