import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/screen_padding.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/top_icon.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  bool _isLoading = false;

  Future<void> _onLogout() async {
    setState(() => _isLoading = true);
    await Future.wait([
      getIt<AuthDB>().clear(),
      Future.delayed(const Duration(seconds: 2)),
    ]);
    if (!mounted) return;
    context.goNamed('request_token');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: MyAppBar(),
      body: ScreenPadding(
        child: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
            child: Container(
              decoration: BoxDecoration(
                color: SecretSantaColors.neutral100,
                borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
                boxShadow: SecretSantaShadows.medium,
                border: Border.all(color: SecretSantaColors.neutral200),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SecretSantaSpacing.xl,
                  vertical: SecretSantaSpacing.xl,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TopIcon(icon: Icons.logout),
                    const SizedBox(height: 32),
                    Text(
                      l10n.logoutLabel,
                      style: SecretSantaTextStyles.labelSmall.copyWith(
                        color: SecretSantaColors.accent,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Título
                    Text(
                      l10n.logoutTitle,
                      style: SecretSantaTextStyles.titleMedium.copyWith(
                        color: SecretSantaColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    
                    // Subtítulo
                    Text(
                      l10n.logoutSubtitle,
                      style: SecretSantaTextStyles.body.copyWith(
                        color: SecretSantaColors.neutral500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    
                    // Botão principal
                    MyGradientButton(
                      onTap: _onLogout,
                      title: l10n.logoutButton,
                      icon: Icons.logout_rounded,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 8),
                    
                    // Divisor com cadeado
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: SecretSantaColors.neutral200,
                            thickness: 1,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: SecretSantaSpacing.md),
                          child: Icon(
                            Icons.lock_outline,
                            size: 14,
                            color: SecretSantaColors.neutral300,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: SecretSantaColors.neutral200,
                            thickness: 1,
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
      ),
    );
  }
}
