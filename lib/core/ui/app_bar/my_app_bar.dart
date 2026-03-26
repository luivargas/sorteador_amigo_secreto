import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/network/contants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String? title;
  final String? subTitle;

  MyAppBar({
    super.key,
    this.actions,
    this.title,
    this.subTitle,
  }) : assert(
          subTitle == null || title != null,
          'subTitle só pode ser informado se title também for.',
        );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  bool get hasText => title != null && title!.isNotEmpty;

  final Image titleImage = Image.asset(logo, scale: 5);

  @override
  Widget build(BuildContext context) {
    Widget? titleWidget;

    if (hasText) {
      titleWidget = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title!, style: TextStyle(fontSize: 20)),
          if (subTitle != null)
            Text(
              subTitle!,
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
            ),
        ],
      );
    } else {
      titleWidget = titleImage;
    }
  

    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      actions: actions,
      title: titleWidget,
      surfaceTintColor: Theme.of(context).canvasColor,
    );
  }
}
