import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_button.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/util/contants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MyAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: Theme.of(context).canvasColor);
  }
}

class MyHomeAppBar extends StatelessWidget {
  const MyHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final title = SizedBox(
      child: Image.asset(logo, scale: 5,),
    );
    final actions = IconButton(
      onPressed: () => showModalBottomSheet<void>(
        backgroundColor: Theme.of(context).canvasColor,
        context: context,
        builder: (context) => GroupButton(),
      ),
      icon: Icon(Icons.add_circle, color: MyColors.sorteadorOrange, size: 30),
    );

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [title, actions]);
  }
}
