class ValidateToken {
  final String email;
  final String token;
  final String device;

  ValidateToken({
    required this.email,
    required this.token,
    required this.device,
  });

  Map<String, dynamic> toJson() {
    return {"email": email.toLowerCase(), "token": token, "device": device};
  }
}
