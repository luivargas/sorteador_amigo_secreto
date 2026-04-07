
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/alert.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/request_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class RequestTokenScreen extends StatefulWidget {
  const RequestTokenScreen({super.key});

  @override
  State<RequestTokenScreen> createState() => _EnterGroup();
}

class _EnterGroup extends State<RequestTokenScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
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
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) =>
          (!p.requested && c.requested) ||
          (p.error != c.error && c.error != null),
      listener: (context, state) {
        if (state.requested) {
          context.pushNamed(
            'validate_token',
            extra: _emailController.text.trim(),
          );
        }
        if (state.error != null) {
          AppAlert.show(
            context,
            message: state.error!.localize(context),
            type: AlertType.error,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: MyAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.verificationTitle, style: SecretSantaTextStyles.h1,),
                      Text(l10n.verificationSubtitle),
                    ],
                  ),
                  MyEmailFormField(
                        controller: _emailController,
                        validator: (_) => ValidatorUtils.emailValidator(
                          context: context,
                          v: _emailController.text,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideX(begin: 0.2, curve: Curves.easeOut),
                  BlocBuilder<AuthCubit, AuthState>(
                        builder: (BuildContext context, AuthState state) {
                          return MyGradientButton(
                            onTap: _onSubmit,
                            title: AppLocalizations.of(context)!.sendCodeButton,
                            isLoading: state.isLoading,
                          );
                        },
                      )
                      .animate()
                      .fadeIn(delay: 150.ms, duration: 400.ms)
                      .slideX(begin: 0.2, curve: Curves.easeOut),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
