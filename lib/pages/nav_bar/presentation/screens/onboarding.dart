import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/cubit/home_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/widgets/info_card.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/widgets/step_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<Color> cardColors = [
    SecretSantaColors.accent,
    SecretSantaColors.accent2,
  ];

  Color getColor(int index) {
    return cardColors[index % cardColors.length];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: SecretSantaColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: SecretSantaColors.primaryGradient,
                            ),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.onboardingHeroTitle,
                                  style: const TextStyle(
                                    color: SecretSantaColors.neutral50,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  l10n.onboardingHeroDesc,
                                  style: TextStyle(
                                    color: SecretSantaColors.neutral50.withValues(
                                      alpha: 0.7,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: FloatingActionButton(
                                          backgroundColor: SecretSantaColors.neutral50,
                                          onPressed: () async {
                                            final result = await context.push(
                                              "/create_group",
                                            );
                                            if (!context.mounted) return;
                                            if (result == true) {
                                              () => context.read<HomeCubit>().refreshGroups();
                                            }
                                          },
                                          child: Text(
                                            l10n.createMyGroup,
                                            style: TextStyle(
                                              color: SecretSantaColors.accent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.onboardingHowItWorks,
                    style: SecretSantaTextStyles.titleSmall,
                  ),
                  Column(
                    spacing: 25,
                    children: [
                      StepCard(
                        step: "01",
                        icon: Icons.create,
                        title: l10n.onboardingStep1AltTitle,
                        description: l10n.onboardingStep1AltDesc,
                        color: getColor(0),
                      ),
                      StepCard(
                        step: "02",
                        icon: Icons.settings,
                        title: l10n.onboardingStep2AltTitle,
                        description: l10n.onboardingStep2AltDesc,
                        color: getColor(1),
                      ),
                      StepCard(
                        step: "03",
                        icon: Icons.group_add,
                        title: l10n.onboardingStep3AltTitle,
                        description: l10n.onboardingStep3AltDesc,
                        color: getColor(2),
                      ),
                      StepCard(
                        step: "04",
                        icon: Icons.celebration,
                        title: l10n.onboardingStep4AltTitle,
                        description: l10n.onboardingStep4AltDesc,
                        color: getColor(3),
                      ),
                      InfoCard(
                        title: l10n.onboardingFreeTitle,
                        description: l10n.onboardingFreeDesc,
                        backgroundColor: SecretSantaColors.accent2,
                        icon: Icons.volunteer_activism,
                        iconBackgroundColor: SecretSantaColors.accent,
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
