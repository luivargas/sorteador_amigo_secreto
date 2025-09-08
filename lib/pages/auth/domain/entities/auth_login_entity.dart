class AuthLoginEntity {
  final String email;
  final String password;

  AuthLoginEntity({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'password': password, 'email': email};
  }
}
