import 'package:flutter/material.dart';

/// Campo de e-mail com ícone, hint e teclado padrão do app.
/// O validator é opcional pois varia entre formulários (obrigatório, opcional, customizado).
class MyEmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;

  const MyEmailFormField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.textInputAction,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    textInputAction: textInputAction,
    readOnly: readOnly,
    keyboardType: TextInputType.emailAddress,
    validator: validator,
    decoration: const InputDecoration(
      hintText: 'Ex: simba@disney.com',
      prefixIcon: Icon(Icons.email),
    ),
  );
}
