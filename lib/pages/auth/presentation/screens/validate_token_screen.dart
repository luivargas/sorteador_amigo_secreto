import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    text: widget.email.toLowerCase(),
  );
  bool _success = false;

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
      listenWhen: (p, c) =>
          (!p.validated && c.validated) || (p.error != c.error),
      listener: (context, state) {
        if (state.validated) {
          setState(() => _success = true);
          Future.delayed(const Duration(milliseconds: 1200), () {
            if (mounted) context.goNamed('nav_bar', extra: state.groups ?? []);
          });
        }
      },
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
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _success
                            ? Icon(
                                Icons.check_circle,
                                size: 100,
                                color: SecretSantaColors.success,
                                key: const ValueKey('check'),
                              ).animate().scale(
                                begin: const Offset(0.5, 0.5),
                                curve: Curves.elasticOut,
                                duration: 600.ms,
                              )
                            : const Icon(
                                Icons.email,
                                size: 100,
                                key: ValueKey('email'),
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
                            style: SecretSantaTextStyles.titleLarge,
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
                      Row(
                        children: [
                          Expanded(
                            child: SecretSantaCard(
                              color: SecretSantaColors.neutral50,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Column(
                                  spacing: 20,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        final pinField =
                                            MaterialPinField(
                                                  length: 6,
                                                  theme: MaterialPinTheme(
                                                    cursorColor:
                                                        SecretSantaColors
                                                            .neutral50,
                                                    completeBorderColor:
                                                        SecretSantaColors
                                                            .accent2,
                                                    filledFillColor:
                                                        SecretSantaColors
                                                            .neutral50,
                                                    filledBorderColor:
                                                        SecretSantaColors
                                                            .accent2,
                                                    fillColor: SecretSantaColors
                                                        .neutral50,
                                                    textStyle:
                                                        SecretSantaTextStyles
                                                            .pinField,
                                                    shape: MaterialPinShape
                                                        .outlined,
                                                    spacing: 10,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    borderColor:
                                                        SecretSantaColors
                                                            .accent,
                                                    entryAnimation:
                                                        MaterialPinAnimation
                                                            .scale,
                                                  ),
                                                  errorBuilder: (errorText) =>
                                                      Container(
                                                        padding: EdgeInsets.all(
                                                          8,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.error,
                                                              color: Colors.red,
                                                              size: 16,
                                                            ),
                                                            SizedBox(width: 8),
                                                            Text(
                                                              errorText ?? '',
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                  onCompleted: (value) async {
                                                    await _onSubmit(value);
                                                  },
                                                )
                                                .animate()
                                                .fadeIn(
                                                  delay: 150.ms,
                                                  duration: 400.ms,
                                                );
                                        return state.error != null
                                            ? pinField
                                                  .animate(
                                                    key: ValueKey(state.error),
                                                  )
                                                  .shake(
                                                    duration: 400.ms,
                                                    hz: 4,
                                                  )
                                            : pinField;
                                      },
                                    ),
                                    TextButton.icon(
                                      onPressed: () async {
                                        final data = await Clipboard.getData(
                                          Clipboard.kTextPlain,
                                        );
                                        final text = data?.text?.trim() ?? '';
                                        if (text.length == 6) {
                                          _tokenController.text = text;
                                          await _onSubmit(text);
                                        }
                                      },
                                      icon: const Icon(Icons.content_paste),
                                      label: Text(l10n.pasteCode),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
