import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';

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
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Nome'),
            TextFormField(
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
              keyboardType: TextInputType.emailAddress,
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
                  countrySelectorNavigator: CountrySelectorNavigator.dialog(
                    backgroundColor: Theme.of(context).canvasColor,
                    titleStyle: myTheme.textTheme.titleSmall,
                    searchBoxTextStyle: myTheme.inputDecorationTheme.labelStyle,
                  ),
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
