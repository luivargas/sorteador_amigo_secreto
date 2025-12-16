// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

enum ParticipantRole { admin }

class ViewParticipantFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final PhoneController phoneController;
  final ShowParticipantModel participant;
  final bool readOnly;

  const ViewParticipantFormFields({
    super.key,
    required this.nameController,
    required this.readOnly,
    required this.emailController,
    required this.phoneController,
    required this.participant,
  });

  @override
  State<ViewParticipantFormFields> createState() =>
      _ViewParticipantFormFields();
}

class _ViewParticipantFormFields extends State<ViewParticipantFormFields> {
  late ShowParticipantModel data = widget.participant;

  String? _validator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _emailValidator(String? v) {
    if (data.role == ParticipantRole.admin) {
      if (v == null || v.trim().isEmpty) {
        return 'Informe seu e-mail';
      }
      final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim());
      return ok ? null : 'E-mail inválido';
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
              readOnly: widget.readOnly,
              validator: _validator,
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
                  keyboardType: TextInputType.numberWithOptions(),
                  countrySelectorNavigator: CountrySelectorNavigator.dialog(
                    backgroundColor: Theme.of(context).canvasColor,
                    titleStyle: myTheme.textTheme.titleSmall,
                    searchBoxTextStyle: myTheme.inputDecorationTheme.labelStyle,
                  ),
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
