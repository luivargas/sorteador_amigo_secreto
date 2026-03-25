import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/network/contants.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/labeled_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_name_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_phone_form_field.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

enum ParticipantRole { admin, participant, observer }

class ViewParticipantFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final PhoneController phoneController;
  final ShowParticipantModel? participant;
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
  String? _emailValidator(BuildContext context, String? v) {
    // Guard: dados ainda não carregados, sem validação
    final data = widget.participant;
    if (data == null) return null;

    // Compara role como String (valor retornado pela API)
    if (data.role == 'admin') {
      return ValidatorUtils.emailValidator(context: context, v: v);
    }
    if (v != null && v.isNotEmpty) {
      return ValidatorUtils.isValidEmail(context: context, v: v);
    }
    return null;
  }

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
            readOnly: widget.readOnly,
            autofocus: true,
          ),
        ),
        LabeledField(
          label: l10n.email,
          child: MyEmailFormField(
            controller: widget.emailController,
            textInputAction: TextInputAction.next,
            readOnly: widget.readOnly,
            validator: (v) => _emailValidator(context, v),
          ),
        ),
        LabeledField(
          label: l10n.phoneField,
          child: MyPhoneFormField(
            controller: widget.phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            enableInteractiveSelection: widget.readOnly,
            enabled: !widget.readOnly,
            favorites: favoriteIsoList,
            navigatorHeight: 400,
            validator: PhoneValidator.compose([
              PhoneValidator.validMobile(context),
            ]),
          ),
        ),
      ],
    );
  }
}
