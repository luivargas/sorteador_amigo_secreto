import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_body.dart';
import 'package:sorteador_amigo_secreto/core/ui/form_fields/labeled_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/form_fields/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/form_fields/my_name_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/form_fields/my_phone_form_field.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/core/validator/participant/participant_validators.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class CreateParticipantFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final PhoneController phoneController;

  const CreateParticipantFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  State<CreateParticipantFormFields> createState() =>
      _CreateParticipantFormFields();
}

class _CreateParticipantFormFields extends State<CreateParticipantFormFields> {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return FormBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SecretSantaSpacing.lg,
        children: [
          LabeledField(
            label: i18n.name,
            child: MyNameFormField(
              controller: widget.nameController,
              hintText: i18n.participantNameHint,
              textInputAction: TextInputAction.next,
            ),
          ),
          LabeledField(
            label: i18n.email,
            child: MyEmailFormField(
              controller: widget.emailController,
              textInputAction: TextInputAction.next,
              validator: (_) => ParticipantValidators.emailOrPhoneValidator(
                context: context,
                email: widget.emailController.text,
                phone: widget.phoneController.value.nsn,
              ),
            ),
          ),
          LabeledField(
            label: i18n.phoneField,
            child: MyPhoneFormField(
              controller: widget.phoneController,
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }
}
