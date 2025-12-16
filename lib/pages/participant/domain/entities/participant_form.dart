import 'package:phone_form_field/phone_form_field.dart';

enum ParticipantRole { admin, participant }

class ParticipantForm {
  final String name;
  final PhoneNumber? phone;
  final String? email;
  final ParticipantRole role;

  ParticipantForm(
    this.phone,
    this.email, {
    required this.name,
    required this.role,
  });
}
