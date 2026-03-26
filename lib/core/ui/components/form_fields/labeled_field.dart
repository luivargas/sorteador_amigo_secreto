import 'package:flutter/material.dart';

/// Envolve qualquer campo com um label acima, no padrão usado em todos os formulários.
class LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const LabeledField({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 10,
    children: [Text(label), child],
  );
}
