import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';

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
  Widget build(BuildContext context) => TextFormField(
    keyboardType: TextInputType.number,
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
  );
}
