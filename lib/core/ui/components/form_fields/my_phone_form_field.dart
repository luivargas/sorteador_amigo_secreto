import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/network/contants.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class MyPhoneFormField extends StatelessWidget {
  final PhoneController controller;
  final FormFieldValidator<PhoneNumber>? validator;
  final bool enabled;
  final bool? enableInteractiveSelection;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final double? navigatorHeight;

  const MyPhoneFormField({
    super.key,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.enableInteractiveSelection,
    this.textInputAction,
    this.keyboardType = const TextInputType.numberWithOptions(),
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

  /// Abre o seletor de país de forma independente, sem PhoneFormField.
  static Future<IsoCode?> showCountrySelector(BuildContext context) =>
      _buildNavigator(context).show(context);

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      controller: controller,
      validator: validator,
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
