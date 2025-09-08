import 'package:flutter/material.dart';

class SubmitGroupFormButton extends StatelessWidget {
  const SubmitGroupFormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: FloatingActionButton(
            onPressed: () {},
            child: Text(
              'Criar Grupo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
      ],
    );
  }
}
