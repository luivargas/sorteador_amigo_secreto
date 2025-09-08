import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_button.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;

  const MyAppBar({super.key, this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final title = SizedBox(
      width: 100,
      child: Image.asset('./assets/logos/full/Logo_6.png'),
    );

    return AppBar(title: title, backgroundColor: myTheme.canvasColor);
  }
}

class MyHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;

  const MyHomeAppBar({super.key, this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final title = SizedBox(
      width: 100,
      child: Image.asset('./assets/logos/full/Logo_6.png'),
    );
    final actions = [
      IconButton(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          builder: (context) => GroupButton(),
        ),
        icon: Icon(Icons.add_circle, color: Colors.white, size: 30),
      ),
    ];

    return AppBar(
      title: title,
      actions: actions,
      backgroundColor: myTheme.canvasColor,
    );
  }
}
