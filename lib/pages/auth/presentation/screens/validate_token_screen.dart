import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_token_form_field.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';

class ValidateTokenScreen extends StatefulWidget {
  final String email;

  const ValidateTokenScreen({super.key, required this.email});

  @override
  State<ValidateTokenScreen> createState() => _ValidateTokenScreenState();
}

class _ValidateTokenScreenState extends State<ValidateTokenScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _tokenController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController(
    text: widget.email,
  );

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();

    await context.read<AuthCubit>().validateToken(_tokenController.text.trim());
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) => !p.validated && c.validated,
      listener: (context, state) =>
          context.goNamed('nav_bar', extra: state.groups ?? []),
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: MyAppBar(
            title: 'Quase lá!',
            subTitle: 'Digite o código que enviamos para o seu e-mail',
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 0),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state.error != null) {
                    Text(
                      state.error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      MyEmailFormField(
                        controller: _emailController,
                        readOnly: true,
                      ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, curve: Curves.easeOut),
                      MyTokenFormField(controller: _tokenController)
                          .animate()
                          .fadeIn(delay: 150.ms, duration: 400.ms)
                          .slideX(begin: 0.2, curve: Curves.easeOut),
                      MyGradientButton(
                        onTap: () {
                          state.isLoading ? null : _onSubmit();
                        },
                        title: 'Confirmar código',
                        isLoading: state.isLoading,
                      ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideX(begin: 0.2, curve: Curves.easeOut),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
