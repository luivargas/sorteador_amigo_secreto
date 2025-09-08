import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/auth_register_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';
import 'package:sorteador_amigo_secreto/pages/auth/widgets/register_form_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  String? forceErrorText;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório";
    }
    if (passwordController.text != passwordConfirmController.text) {
      return "Senhas estão diferentes";
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
    final bool isValidPassword = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    if (!isValidPassword) {
      return;
    }
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    final entity = AuthRegisterEntity(
      firstName: firstName,
      lastName: lastName,
      password: password,
      email: email,
    );
    getIt<AuthCubit>().register(entity);
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
          if (state.isRegister == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Cadastro realizado com sucesso")),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: MyAppBar(),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 300,
                      maxWidth: 600,
                      minHeight: 400,
                      maxHeight: 900,
                    ),
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
                                  'Cadastre-se',
                                  style: myTheme.textTheme.titleSmall,
                                ),
                              ],
                            ),
                            RegisterFormField(
                              validator: validator,
                              passwordValidator: passwordValidator,
                              firstNameController: firstNameController,
                              lastNameController: lastNameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              passwordConfirmController:
                                  passwordConfirmController,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _onSubmit();
                                      },
                                      child: Text('Criar conta'),
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
            ),
          );
        },
      ),
    );
  }
}
