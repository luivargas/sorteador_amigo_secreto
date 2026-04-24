import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/card_color.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/screen_padding.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/top_icon.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/widgets/info_card.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/widgets/step_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: SecretSantaColors.background,
      body: ScreenPadding(
        child: SingleChildScrollView(
          child: Column(
            spacing: SecretSantaSpacing.xl,
            children: [
              Row(
                spacing: SecretSantaSpacing.lg,
                children: [
                  TopIcon(icon: Icons.card_giftcard),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.onboardingGuideTitle,
                          style: SecretSantaTheme.theme.textTheme.titleSmall,
                        ),
                        Text(
                          l10n.onboardingGuideSubtitle,
                          style: TextStyle(color: SecretSantaColors.neutral600.withValues(alpha: 0.8)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          
              Column(
                spacing:  SecretSantaSpacing.md,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.onboardingHowItWorks,
                    style: SecretSantaTextStyles.titleSmall,
                  ),
                  Column(
                    spacing: SecretSantaSpacing.sm,
                    children: [
                      StepCard(
                        step: "01",
                        icon: Icons.create,
                        title: l10n.onboardingStep1AltTitle,
                        description: l10n.onboardingStep1AltDesc,
                        color: CardColor.getColor(0),
                      ),
                      StepCard(
                        step: "02",
                        icon: Icons.settings,
                        title: l10n.onboardingStep2AltTitle,
                        description: l10n.onboardingStep2AltDesc,
                        color: CardColor.getColor(1),
                      ),
                      StepCard(
                        step: "03",
                        icon: Icons.group_add,
                        title: l10n.onboardingStep3AltTitle,
                        description: l10n.onboardingStep3AltDesc,
                        color: CardColor.getColor(2),
                      ),
                      StepCard(
                        step: "04",
                        icon: Icons.celebration,
                        title: l10n.onboardingStep4AltTitle,
                        description: l10n.onboardingStep4AltDesc,
                        color: CardColor.getColor(3),
                        isLast: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:SecretSantaSpacing.lg),
                        child: InfoCard(
                          title: l10n.onboardingFreeTitle,
                          description: l10n.onboardingFreeDesc,
                          backgroundColor: SecretSantaColors.accent2,
                          icon: Icons.volunteer_activism,
                          iconBackgroundColor: SecretSantaColors.accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
