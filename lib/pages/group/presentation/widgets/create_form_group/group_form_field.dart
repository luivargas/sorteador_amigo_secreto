import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

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
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(l10n.yourName),
            TextFormField(
              validator: (_) => ValidatorUtils.nameValidator(context: context, v: widget.nameController.text),
              controller: widget.nameController,
              decoration: InputDecoration(
                hintText: l10n.nameHint,
                prefixIcon: const Icon(Icons.abc),
              ),
            ),
            Text(l10n.email),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (_) => ValidatorUtils.emailValidator(context: context, v: widget.emailController.text),
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
                Text(l10n.phoneField),
                PhoneFormField(
                  controller: widget.phoneController,
                  keyboardType: TextInputType.numberWithOptions(),
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
            Text(l10n.groupName),
            TextFormField(
              validator: (_) => ValidatorUtils.nameValidator(context: context, v: widget.groupNameController.text),
              controller: widget.groupNameController,
              decoration: InputDecoration(
                hintText: l10n.groupNameHint,
                prefixIcon: const Icon(Icons.group),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
