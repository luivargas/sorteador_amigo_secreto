import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

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
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 10,
    children: [
      Text(AppLocalizations.of(context)!.email),
      TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        readOnly: readOnly,
        keyboardType: TextInputType.emailAddress,
        validator: validator,
        decoration: InputDecoration(
          hintText: 'Ex: simba@disney.com',
          prefixIcon: const Icon(Icons.email),
          filled: readOnly,
          fillColor: readOnly ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
          enabledBorder: readOnly
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
        ),
      ),
    ],
  );
}
