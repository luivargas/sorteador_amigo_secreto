import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class ScreenPadding extends StatelessWidget {
  final Widget child;
  const ScreenPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SecretSantaSpacing.lg,
        SecretSantaSpacing.lg,
        SecretSantaSpacing.lg,
        0
      ),
      child: SafeArea(top: false,child: child),
    );
  }
}
