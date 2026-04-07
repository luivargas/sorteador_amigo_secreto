import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/network/contants.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  MyAppBar({
    super.key,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final Image titleImage = Image.asset(logo, scale: 5);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: SecretSantaColors.background,
      actions: actions,
      title: titleImage,
      surfaceTintColor: SecretSantaColors.background,
    );
  }
}
