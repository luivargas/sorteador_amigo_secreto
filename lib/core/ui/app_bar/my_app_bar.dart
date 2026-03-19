// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  List<Widget>? actions;
  String title;
  String? subTitle;
  MyAppBar({super.key, this.actions, required this.title, this.subTitle});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      actions: actions,
      title: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 20),),
          Text(subTitle ?? "", style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),)
        ],
      ),
      surfaceTintColor: Theme.of(context).canvasColor,
    );
  }
}

