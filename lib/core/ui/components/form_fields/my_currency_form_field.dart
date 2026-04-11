import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCurrencyFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;

  const MyCurrencyFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator, this.textInputAction,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      CentavosInputFormatter(casasDecimais: 2, moeda: false),
    ],
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.attach_money),
      hintText: hintText,
    ),
    textInputAction: textInputAction
  );
}
