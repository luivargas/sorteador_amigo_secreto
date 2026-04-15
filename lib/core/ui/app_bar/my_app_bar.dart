import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/network/url/contants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  MyAppBar({super.key, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final Image titleImage = Image.asset(logo, scale: 4);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: titleImage,
    );
  }
}
