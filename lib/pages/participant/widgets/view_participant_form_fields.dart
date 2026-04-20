import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_body.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/labeled_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_name_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/validator/participant/participant_validators.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class ViewParticipantFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final PhoneController phoneController;
  final ParticipantModel? participant;
  final bool readOnly;

  const ViewParticipantFormFields({
    super.key,
    required this.participant,
    required this.nameController,
    required this.readOnly,
    required this.emailController,
    required this.phoneController,
  });

  @override
  State<ViewParticipantFormFields> createState() =>
      _ViewParticipantFormFields();
}

class _ViewParticipantFormFields extends State<ViewParticipantFormFields> {

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final role = widget.participant?.role;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: SecretSantaSpacing.sm,
      children: [
        FormBody(
          child: Column(
            children: [
              LabeledField(
                label: l10n.name,
                child: MyNameFormField(
                  controller: widget.nameController,
                  hintText: l10n.participantNameHint,
                  textInputAction: TextInputAction.next,
                  readOnly: widget.readOnly,
                  autofocus: true,
                ),
              ),
              LabeledField(
                label: l10n.email,
                child: MyEmailFormField(
                  controller: widget.emailController,
                  textInputAction: TextInputAction.next,
                  readOnly: widget.readOnly || role == ParticipantRole.admin.name,
                  validator: (_) => ParticipantValidators.emailOrPhoneValidator(
                    context: context,
                    email: widget.emailController.text,
                    phone: widget.phoneController.value.nsn,
                  ),
                ),
              ),
              LabeledField(
                label: l10n.phoneField,
                child: MyPhoneFormField(
                  controller: widget.phoneController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  enableInteractiveSelection: widget.readOnly,
                  enabled: !widget.readOnly,
                  navigatorHeight: 400,
                  validator: PhoneValidator.compose([
                    PhoneValidator.valid(context),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
