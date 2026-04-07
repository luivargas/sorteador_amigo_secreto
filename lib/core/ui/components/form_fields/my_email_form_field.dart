import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

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
    decoration: InputDecoration(
      hintText: 'Ex: simba@disney.com',
      prefixIcon: const Icon(Icons.email),
      filled: true,
      fillColor: readOnly
          ? SecretSantaColors.neutral200
          : SecretSantaColors.neutral50,
      enabledBorder: readOnly
          ? OutlineInputBorder(
              borderSide: BorderSide(
                color: SecretSantaColors.neutral300,
              ),
              borderRadius: BorderRadius.circular(12),
            )
          : null,
    ),
  );
}
