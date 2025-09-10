import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_button.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    return AppBar(backgroundColor: myTheme.canvasColor);
  }
}

class MyHomeAppBar extends StatelessWidget {
  const MyHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final title = SizedBox(
      child: Image.asset('./assets/logos/full/Logo_3.png', scale: 15,),
    );
    final actions = IconButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        builder: (context) => GroupButton(),
      ),
      icon: Icon(Icons.add_circle, color: MyColors.sorteadorOrange, size: 30),
    );

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [title, actions]);
  }
}
