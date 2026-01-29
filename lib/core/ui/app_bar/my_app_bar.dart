// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  List<Widget>? actions;
  MyAppBar({super.key, this.actions});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      actions: actions,
      title: Image.asset(
        './assets/logos/full/logo_amigo_secreto.png',
        scale: 5,
      ),
      surfaceTintColor: Theme.of(context).canvasColor,
    );
  }
}

