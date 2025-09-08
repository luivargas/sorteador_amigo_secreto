import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/form_group/form_group_body.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroup();
}

class _CreateGroup extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 300,
          maxWidth: 600,
          minHeight: 400,
          maxHeight: 800,
        ),
        child: FormGroupBody(),
      ),
    );
  }
}
