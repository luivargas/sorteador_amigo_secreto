import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class MyPhoneFormField extends StatelessWidget {
  final PhoneController controller;
  final FormFieldValidator<PhoneNumber>? validator;
  final bool enabled;
  final bool? enableInteractiveSelection;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final List<IsoCode> favorites;
  final double? navigatorHeight;

  const MyPhoneFormField({
    super.key,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.enableInteractiveSelection,
    this.textInputAction,
    this.keyboardType = const TextInputType.numberWithOptions(),
    this.favorites = const [],
    this.navigatorHeight,
  });

  static CountrySelectorNavigator _buildNavigator(
    BuildContext context, {
    List<IsoCode> favorites = const [],
  }) => CountrySelectorNavigator.dialog(
    backgroundColor: Theme.of(context).canvasColor,
    titleStyle: Theme.of(context).textTheme.titleSmall,
    searchBoxTextStyle: Theme.of(context).inputDecorationTheme.labelStyle,
    favorites: favorites.isEmpty ? null : favorites,
    height: 400,
  );

  /// Abre o seletor de país de forma independente, sem PhoneFormField.
  static Future<IsoCode?> showCountrySelector(BuildContext context) =>
      _buildNavigator(context).show(context);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(AppLocalizations.of(context)!.phone),
        PhoneFormField(
          controller: controller,
          validator: validator,
          enabled: enabled,
          enableInteractiveSelection: enableInteractiveSelection ?? true,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          isCountrySelectionEnabled: true,
          isCountryButtonPersistent: true,
          countryButtonStyle: const CountryButtonStyle(),
          countrySelectorNavigator: _buildNavigator(
            context,
            favorites: favorites,
          ),
        ),
      ],
    );
  }
}
