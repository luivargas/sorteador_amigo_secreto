import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
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
    await getIt<AuthDB>().clear();
    if (!mounted) return;
    context.goNamed('splash');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: SecretSantaColors.neutral100,
              borderRadius: BorderRadius.circular(20),
              boxShadow: SecretSantaShadows.medium,
              border: Border.all(color: SecretSantaColors.neutral200,)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 48, 32, 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícone
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: SecretSantaColors.neutral50,
                      shape: BoxShape.circle,
                      boxShadow: SecretSantaShadows.small,
                    ),
                    child: const Icon(
                      Icons.logout_rounded,
                      size: 56,
                      color: SecretSantaColors.accent,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Label
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
                    style: SecretSantaTextStyles.h3.copyWith(
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
                        padding: EdgeInsets.symmetric(horizontal: 12),
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
    );
  }
}
