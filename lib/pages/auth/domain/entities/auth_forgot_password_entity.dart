class AuthForgotPasswordEntity {
  final String email;

  AuthForgotPasswordEntity({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}