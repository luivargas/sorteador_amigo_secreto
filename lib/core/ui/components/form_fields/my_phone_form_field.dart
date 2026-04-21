import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/network/url/contants.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class MyPhoneFormField extends StatelessWidget {
  final PhoneController controller;
  final bool enabled;
  final bool? enableInteractiveSelection;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final double? navigatorHeight;

  const MyPhoneFormField({
    super.key,
    required this.controller,
    this.enabled = true,
    this.enableInteractiveSelection,
    this.textInputAction,
    this.keyboardType = TextInputType.phone,
    this.navigatorHeight,
  });

  static CountrySelectorNavigator _buildNavigator(BuildContext context) =>
      CountrySelectorNavigator.dialog(
        backgroundColor: SecretSantaColors.background,
        titleStyle: SecretSantaTextStyles.titleSmall,
        searchBoxTextStyle: SecretSantaTextStyles.body.copyWith(
          color: SecretSantaColors.accent.withValues(alpha: 0.5),
        ),
        favorites: favoriteIsoList,
      );

  static Future<IsoCode?> showCountrySelector(BuildContext context) =>
      _buildNavigator(context).show(context);

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      decoration: InputDecoration(
        helperText: "DDD + ${AppLocalizations.of(context)!.phone}",
        hintText: 'DDD + ${AppLocalizations.of(context)!.phone}',
      ),
      controller: controller,
      validator: PhoneValidator.compose([
        PhoneValidator.valid(
          context,
          errorText:
              'Número inválido.\nInclua o DDD + número\nEx: (11) 99999-9999',
        ),
      ]),
      enabled: enabled,
      enableInteractiveSelection: enableInteractiveSelection ?? true,
      textInputAction: textInputAction,
      keyboardType: TextInputType.phone,
      isCountrySelectionEnabled: true,
      isCountryButtonPersistent: true,
      countryButtonStyle: const CountryButtonStyle(),
      countrySelectorNavigator: _buildNavigator(context),
    );
  }
}
