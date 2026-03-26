import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

/// Campo de nome com ícone, hint e validator padrão do app.
/// O validador sempre exige que o campo não esteja vazio.
class MyTokenFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData icon;
  final bool readOnly;
  final bool autofocus;
  final TextInputAction? textInputAction;

  const MyTokenFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.icon = Icons.code,
    this.readOnly = false,
    this.autofocus = false,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 10,
    children: [
      Text("Código de verificação"),
      TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        readOnly: readOnly,
        autofocus: autofocus,
        validator: (_) =>
            ValidatorUtils.tokenValidator(context: context, v: controller.text),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          enabledBorder: readOnly ? OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(12),
          )
          : null,
        ),
      ),
    ],
  );
}
