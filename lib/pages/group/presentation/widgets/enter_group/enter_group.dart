import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/enter_group/enter_group_body.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class EnterGroup extends StatefulWidget {
  const EnterGroup({super.key});

  @override
  State<EnterGroup> createState() => _EnterGroup();
}

class _EnterGroup extends State<EnterGroup> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController codeFieldController = TextEditingController();

  @override
  void dispose() {
    codeFieldController.dispose();
    super.dispose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Entrar no grupo',
                          style: myTheme.textTheme.titleSmall,
                        ),
                      ],
                    ),
                    EnterGroupBody(
                      codeFieldController: codeFieldController,
                      validator: validator,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Entrar no grupo'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
