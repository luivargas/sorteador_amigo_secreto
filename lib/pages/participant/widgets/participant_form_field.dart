import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class ParticipantFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final PhoneController phoneController;

  const ParticipantFormFields({ 
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  State<ParticipantFormFields> createState() => _ParticipantFormFieldsState();
}

class _ParticipantFormFieldsState extends State<ParticipantFormFields> {
  String? usString;

  String? _validator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Informe seu e-mail';
    }
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim());
    return ok ? null : 'E-mail inválido';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Seu nome'),
            TextFormField(
              validator: _validator,
              controller: widget.nameController,
              decoration: const InputDecoration(
                hintText: 'Ex: Simba',
                prefixIcon: Icon(Icons.abc),
              ),
            ),
            Text('E-mail'),
            TextFormField(
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
                  controller: widget.phoneController,
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: PhoneValidator.compose([
                    PhoneValidator.required(
                      context,
                      errorText: "Informe seu telefone",
                    ),
                    PhoneValidator.validMobile(context),
                  ]),
                  countrySelectorNavigator: CountrySelectorNavigator.dialog(
                    backgroundColor: Theme.of(context).canvasColor,
                    titleStyle: myTheme.textTheme.titleSmall,
                    searchBoxTextStyle: myTheme.inputDecorationTheme.labelStyle,
                  ),
                  enabled: true,
                  isCountrySelectionEnabled: true,
                  isCountryButtonPersistent: true,
                  countryButtonStyle: CountryButtonStyle(),
                ),
              ],
            ),
          ]
        )
      ],
    );
  }
}
