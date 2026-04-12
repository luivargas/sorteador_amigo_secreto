import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/pages/participant/core/util/participant_validators.dart';

class MyNameFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData icon;
  final bool readOnly;
  final bool autofocus;
  final TextInputAction? textInputAction;

  const MyNameFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.icon = Icons.abc,
    this.readOnly = false,
    this.autofocus = false,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    textCapitalization: TextCapitalization.sentences,
    keyboardType: TextInputType.text,
    controller: controller,
    textInputAction: textInputAction,
    readOnly: readOnly,
    autofocus: autofocus,
    validator: (_) =>
        ParticipantValidators.nameValidator(context: context, v: controller.text),
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
    ),
  );
}
