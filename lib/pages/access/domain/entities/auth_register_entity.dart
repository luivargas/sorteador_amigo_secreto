class AuthRegisterEntity {
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String password;

  AuthRegisterEntity({
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'email': email,
    };
  }
}
