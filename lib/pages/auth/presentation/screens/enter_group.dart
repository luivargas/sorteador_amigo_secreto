import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_name_form_field.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/request_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class EnterGroup extends StatefulWidget {
  const EnterGroup({super.key});

  @override
  State<EnterGroup> createState() => _EnterGroup();
}

class _EnterGroup extends State<EnterGroup> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController codeFieldController = TextEditingController();

  Future<void> _onSubmit() async {
    final entity = RequestToken(email: codeFieldController.text);
    await context.read<AuthCubit>().request(entity);
  }

  @override
  void dispose() {
    codeFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    children: [
                      Text(
                        'Entrar no grupo',
                        style: myTheme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.groupCode),
                      MyNameFormField(
                        controller: codeFieldController,
                        icon: Icons.code,
                      ),
                    ],
                  ),
                  MyGradientButton(onTap: _onSubmit, title: AppLocalizations.of(context)!.email)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
