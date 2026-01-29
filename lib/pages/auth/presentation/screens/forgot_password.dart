import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/auth_forgot_password_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  var showPassword = true;
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? forceErrorText;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  void onChange(String value) {
    if (forceErrorText != null) {
      setState(() {
        forceErrorText = null;
      });
    }
  }

  Future<void> _onSubmit() async {
    final bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    final entity = AuthForgotPasswordEntity(email: emailController.text.trim());
    getIt<AuthCubit>().forgotPassword(entity);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.error != null && state.error!.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
          if (state.resetPassword == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("E-mail enviado com sucesso")),
            );
            context.replace('/login');
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: MyAppBar(),
              backgroundColor: Theme.of(context).canvasColor,
              body: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 300,
                  maxWidth: 600,
                  minHeight: 400,
                  maxHeight: 800,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
                    child: Column(
                      spacing: 20,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Esqueci minha senha',
                              style: myTheme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('E-mail'),
                            TextFormField(
                              forceErrorText: forceErrorText,
                              controller: emailController,
                              validator: validator,
                              decoration: InputDecoration(
                                hintText: 'Digite seu e-mail',
                                prefixIcon: const Icon(Icons.email),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _onSubmit();
                                },
                                child: Text("Enviar"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
