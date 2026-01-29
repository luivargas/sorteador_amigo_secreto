// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';

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
  String? _emailValidator(String? v) {
    ShowParticipantModel data = widget.participant!;
    if (data.role == ParticipantRole.admin) {
      return ValidatorUtils.emailValidator(v: v);
    }
    if (data.role != ParticipantRole.admin && v != null) {
      return ValidatorUtils.isValidEmail(v: v);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Nome'),
            TextFormField(
              autofocus: true,
              readOnly: widget.readOnly,
              validator: (_) =>
                  ValidatorUtils.nameValidator(v: widget.nameController.text),
              controller: widget.nameController,
              decoration: const InputDecoration(
                hintText: 'Ex: Simba',
                prefixIcon: Icon(Icons.abc),
              ),
            ),
            Text('E-mail'),
            TextFormField(
              readOnly: widget.readOnly,
              keyboardType: TextInputType.emailAddress,
              validator: _emailValidator,
              controller: widget.emailController,
              decoration: const InputDecoration(
                hintText: 'Ex: simba@disney.com',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text('DDD + Celular'),
                PhoneFormField(
                  enableInteractiveSelection: widget.readOnly,
                  controller: widget.phoneController,
                  keyboardType: TextInputType.phone,
                  countrySelectorNavigator: CountrySelectorNavigator.dialog(
                    backgroundColor: Theme.of(context).canvasColor,
                    titleStyle: myTheme.textTheme.titleSmall,
                    searchBoxTextStyle: myTheme.inputDecorationTheme.labelStyle,
                  ),
                  validator: PhoneValidator.compose([
                    PhoneValidator.validMobile(context),
                  ]),
                  enabled: !widget.readOnly,
                  isCountrySelectionEnabled: true,
                  isCountryButtonPersistent: true,
                  countryButtonStyle: CountryButtonStyle(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
