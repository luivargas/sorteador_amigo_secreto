import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/auth_login_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  var showPassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? forceErrorText;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
    final email = emailController.text;
    final password = passwordController.text;
    final entity = AuthLoginEntity(password: password, email: email);
    getIt<AuthCubit>().login(entity);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 300,
            maxWidth: 600,
            minHeight: 400,
            maxHeight: 800,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16, top: 20),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    children: [
                      Text('Fazer Login', style: myTheme.textTheme.titleSmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text('Senha'),
                      TextFormField(
                        forceErrorText: forceErrorText,
                        validator: validator,
                        obscureText: showPassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Digite sua senha',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextButton(
                    onPressed: () {
                      context.push('/login_form');
                    },

                    child: Text('Criar conta'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onSubmit();
                          },
                          child: Text("Entrar"),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/forgot_password');
                    },
                    child: Text('Esqueci minha senha'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
