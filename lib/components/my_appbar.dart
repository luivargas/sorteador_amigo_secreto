// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/group_button.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/util/contants.dart';

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

class MyHomeAppBar extends StatelessWidget {
  final void reload;
  const MyHomeAppBar({super.key, required this.reload});

  @override
  Widget build(BuildContext context) {
    final title = SizedBox(child: Image.asset(logo, scale: 5));
    final actions = IconButton(
      onPressed: () async {
        final result = await context.push("/create_group");
        if (result == true) {
          reload;
        }
      },
      // () => showModalBottomSheet<void>(
      //   backgroundColor: Theme.of(context).canvasColor,
      //   context: context,
      //   builder: (context) => GroupButton(),
      // ),
      icon: Icon(Icons.add_circle, color: MyColors.sorteadorOrange, size: 30),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [title, actions],
    );
  }
}
