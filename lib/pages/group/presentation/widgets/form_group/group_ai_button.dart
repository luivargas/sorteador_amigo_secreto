import 'package:flutter/material.dart';

class GroupAiButton extends StatelessWidget {
  const GroupAiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Preencher Descrição e Regras por IA'),
          ),
        ),
      ],
    );
  }
}
