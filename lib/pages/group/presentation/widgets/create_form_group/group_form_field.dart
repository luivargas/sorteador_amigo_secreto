import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_body.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/labeled_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_name_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_phone_form_field.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/core/validator/participant/participant_validators.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class GroupFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController groupNameController;
  final PhoneController phoneController;

  const GroupFormFields({
    super.key,
    required this.groupNameController,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  State<GroupFormFields> createState() => _GroupFormFields();
}

class _GroupFormFields extends State<GroupFormFields> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return FormBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SecretSantaSpacing.sm,
        children: [
          LabeledField(
            label: l10n.groupName,
            child: MyNameFormField(
              controller: widget.groupNameController,
              hintText: l10n.groupNameHint,
              icon: Icons.group,
              textInputAction: TextInputAction.next,
            ),
          ),
          LabeledField(
            label: l10n.yourName,
            child: MyNameFormField(
              controller: widget.nameController,
              hintText: l10n.nameHint,
              textInputAction: TextInputAction.next,
            ),
          ),
          LabeledField(
            label: l10n.phoneField,
            child: MyPhoneFormField(
              controller: widget.phoneController,
              textInputAction: TextInputAction.done,
            ),
          ),
          LabeledField(
            label: l10n.email,
            child: MyEmailFormField(
              controller: widget.emailController,
              validator: (_) =>
                  ParticipantValidators.isRequiredEmailValidator(
                    context: context,
                    v: widget.emailController.text,
                  ),
              readOnly: true,
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }
}
