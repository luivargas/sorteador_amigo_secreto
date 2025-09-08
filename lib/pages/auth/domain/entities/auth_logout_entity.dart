class AuthLogoutEntity {
  final String email;
  final String password;

  AuthLogoutEntity({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'password': password, 'email': email};
  }
}
