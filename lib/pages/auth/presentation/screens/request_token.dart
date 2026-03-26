import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/request_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';

class RequestTokenScreen extends StatefulWidget {
  const RequestTokenScreen({super.key});

  @override
  State<RequestTokenScreen> createState() => _EnterGroup();
}

class _EnterGroup extends State<RequestTokenScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _onSubmit() async {
    final entity = RequestToken(email: _emailController.text);
    await context.read<AuthCubit>().request(entity);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) => !p.requested && c.requested,
      listener: (context, state) =>
          context.pushNamed('validate_token', extra: _emailController.text.trim()),
      child: Form(
        key: _formKey,
        child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: MyAppBar(
          title: 'Verificação de acesso',
          subTitle: 'Enviaremos um código para o seu e-mail',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                MyEmailFormField(controller: _emailController),
                MyGradientButton(onTap: _onSubmit, title: 'Enviar código'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  }
}
