import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/labeled_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_name_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        LabeledField(
          label: l10n.name,
          child: MyNameFormField(
            controller: widget.nameController,
            hintText: 'Ex: Simba',
            textInputAction: TextInputAction.next,
          ),
        ),
        LabeledField(
          label: l10n.email,
          child: MyEmailFormField(
            controller: widget.emailController,
            textInputAction: TextInputAction.next,
            validator: (v) => ValidatorUtils.isValidEmail(context: context, v: widget.emailController.text),
          ),
        ),
        LabeledField(
          label: l10n.phoneField,
          child: MyPhoneFormField(
            controller: widget.phoneController,
            textInputAction: TextInputAction.next,
            validator: PhoneValidator.compose([
              PhoneValidator.valid(context),
            ]),
          ),
        ),
      ],
    );
  }
}
