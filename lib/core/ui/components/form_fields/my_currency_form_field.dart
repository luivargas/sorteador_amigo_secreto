import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Campo de valor monetário com formatação brasileira (R$ 0,00).
/// Usa o CentavosInputFormatter do brasil_fields automaticamente.
class MyCurrencyFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;

  const MyCurrencyFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: TextInputType.numberWithOptions(),
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      CentavosInputFormatter(casasDecimais: 2, moeda: true),
    ],
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.attach_money),
      hintText: hintText,
    ),
  );
}
