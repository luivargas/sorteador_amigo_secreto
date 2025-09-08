class AuthGetUserEntity {
  final String email;

  AuthGetUserEntity({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}