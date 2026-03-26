class RequestToken {
  final String email;

  RequestToken({required this.email});

  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}
