import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_state.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ValidateTokenScreen extends StatefulWidget {
  final String email;

  const ValidateTokenScreen({super.key, required this.email});

  @override
  State<ValidateTokenScreen> createState() => _ValidateTokenScreenState();
}

class _ValidateTokenScreenState extends State<ValidateTokenScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PinInputController _tokenController = PinInputController();
  late final TextEditingController _emailController = TextEditingController(
    text: widget.email,
  );

  Future<void> _onSubmit(String token) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    await context.read<AuthCubit>().validateToken(token.trim());
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) => !p.validated && c.validated,
      listener: (context, state) =>
          context.goNamed('nav_bar', extra: state.groups ?? []),
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: MyAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 0),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      SecretSantaCard(
                        color: SecretSantaColors.neutral50,
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Icon(Icons.email, size: 100),
                        ),
                      ),
                      if (state.error != null)
                        Text(
                          state.error!.localize(context),
                          style: TextStyle(color: SecretSantaColors.error),
                          textAlign: TextAlign.center,
                        ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.almostThereTitle,
                            style: SecretSantaTextStyles.h1,
                          ),
                          Text(
                            l10n.almostThereSubtitle,
                            style: SecretSantaTextStyles.bodySmall,
                          ),
                        ],
                      ),
                      MyEmailFormField(
                            controller: _emailController,
                            readOnly: true,
                          )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: 0.2, curve: Curves.easeOut),
                      PinInput(
                            keyboardType: TextInputType.number,
                            pinController: _tokenController,
                            length: 6,
                            builder: (context, cells) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: cells.map((cell) {
                                  return Container(
                                    width: 40,
                                    height: 45,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      shape: BoxShape.rectangle,
                                      color: cell.isFocused
                                          ? SecretSantaColors.accent
                                          : SecretSantaColors.neutral200,
                                    ),
                                    child: Center(
                                      child: Text(
                                        cell.character ?? '',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                            onCompleted: (value) async {
                              await _onSubmit(value);
                            },
                          )
                          .animate()
                          .fadeIn(delay: 150.ms, duration: 400.ms)
                          .slideX(begin: 0.2, curve: Curves.easeOut),
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
