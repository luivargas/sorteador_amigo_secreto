import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class EnterGroupBody extends StatefulWidget {
  final TextEditingController codeFieldController;
  final FormFieldValidator<String>? validator;
  const EnterGroupBody({
    super.key,
    required this.codeFieldController,
   required this.validator,
  });

  @override
  State<EnterGroupBody> createState() => _EnterGroupBodyState();
}

class _EnterGroupBodyState extends State<EnterGroupBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.groupCode),
              TextFormField(
                controller: widget.codeFieldController,
                validator: widget.validator,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.groupCodeHint,
                  prefixIcon: const Icon(Icons.code),
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
