import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class HomeCard extends StatefulWidget {
  final bool hasGroups;
  const HomeCard({super.key, required this.hasGroups});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.hasGroups) {
      return _CardWhithGroups();
    }
    return _CardEmpty();
  }
}

class _CardWhithGroups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SecretSantaColors.accent2,
            SecretSantaColors.accent3,
            SecretSantaColors.accent,
          ],
        ),
        borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
        boxShadow: SecretSantaShadows.large,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: Icon(
                Icons.card_giftcard,
                size: 80,
                color: SecretSantaColors.neutral50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(SecretSantaSpacing.lg),
            child: Column(
              spacing: SecretSantaSpacing.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              await context.push("/create_group");
                              if (!context.mounted) return;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: SecretSantaColors.neutral50,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SecretSantaSpacing.md,
                                  vertical: SecretSantaSpacing.sm,
                                ),
                                child: Row(
                                  spacing: SecretSantaSpacing.sm,
                                  children: [
                                    Text(
                                      i18n.createGroupButton,
                                      style: TextStyle(
                                        color: SecretSantaColors.accent2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.add_circle_rounded,
                                      color: SecretSantaColors.accent2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SecretSantaColors.accent2,
            SecretSantaColors.accent3,
            SecretSantaColors.accent,
          ],
        ),
        borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
        boxShadow: SecretSantaShadows.large,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: Icon(
                Icons.card_giftcard,
                size: 80,
                color: SecretSantaColors.neutral50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(SecretSantaSpacing.lg),
            child: Column(
              spacing: SecretSantaSpacing.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  i18n.homeCardTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: SecretSantaColors.neutral50,
                  ),
                ),
                Text(
                  i18n.homeCardDesc,
                  style: TextStyle(
                    color: SecretSantaColors.neutral50.withValues(alpha: 0.70),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              await context.push("/create_group");
                              if (!context.mounted) return;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: SecretSantaColors.neutral50,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SecretSantaSpacing.md,
                                  vertical: SecretSantaSpacing.sm,
                                ),
                                child: Row(
                                  spacing: SecretSantaSpacing.sm,
                                  children: [
                                    Text(
                                      i18n.getStarted,
                                      style: TextStyle(
                                        color: SecretSantaColors.accent2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.add_circle_rounded,
                                      color: SecretSantaColors.accent2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
