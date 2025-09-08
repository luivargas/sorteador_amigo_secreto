import 'package:flutter/material.dart';

class EnterGroupBody extends StatefulWidget {
  final TextEditingController codeFieldController;
  final dynamic validator;
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
              Text('Código do grupo'),
              TextFormField(
                controller: widget.codeFieldController,
                validator: widget.validator,
                decoration: const InputDecoration(
                  hintText: 'Coloque aqui o código do grupo',
                  prefixIcon: Icon(Icons.code),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
