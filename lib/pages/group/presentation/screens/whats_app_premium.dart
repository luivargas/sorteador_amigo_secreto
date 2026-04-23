import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/network/url/contants.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappPremiumView extends StatelessWidget {
  const WhatsappPremiumView({super.key});

  Future<void> _openPaymentLink() async {
    final String code = getIt<GroupSession>().code;
    final uri = Uri.parse('$whatsApp/$code');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: SecretSantaSpacing.lg,
                  horizontal: SecretSantaSpacing.lg,
                ),
                decoration: const BoxDecoration(
                  gradient: SecretSantaColors.whatsAppGradient,
                ),
                child: Column(
                  spacing: SecretSantaSpacing.sm,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(SecretSantaSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(
                          SecretSantaRadius.md,
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    Text(
                      i18n.whatsappPremiumTitle,
                      style: SecretSantaTextStyles.titleSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      i18n.whatsappPremiumSubtitle,
                      style: SecretSantaTextStyles.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(SecretSantaSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: SecretSantaSpacing.md,
                  children: [
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'R\$ 5,99',
                              style: SecretSantaTextStyles.titleMedium.copyWith(
                                color: SecretSantaColors.neutral900,
                              ),
                            ),
                            TextSpan(
                              text: ' ${i18n.whatsappPremiumPriceLabel}',
                              style: SecretSantaTextStyles.body.copyWith(
                                color: SecretSantaColors.neutral500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Center(
                      child: Text(
                        i18n.whatsappPremiumDescription,
                        style: SecretSantaTextStyles.bodySmall.copyWith(
                          color: SecretSantaColors.neutral500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Checklist
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(SecretSantaSpacing.md),
                      decoration: BoxDecoration(
                        color: SecretSantaColors.whatsApp.withValues(
                          alpha: 0.08,
                        ),
                        borderRadius: BorderRadius.circular(
                          SecretSantaRadius.lg,
                        ),
                      ),
                      child: Column(
                        spacing: SecretSantaSpacing.sm,
                        children: [
                          _CheckItem(text: i18n.whatsappPremiumCheck1),
                          _CheckItem(text: i18n.whatsappPremiumCheck2),
                          _CheckItem(text: i18n.whatsappPremiumCheck3),
                        ],
                      ),
                    ),
                    Text(
                      i18n.whatsappPremiumHowToActivate,
                      style: SecretSantaTextStyles.labelSmall.copyWith(
                        color: SecretSantaColors.neutral500,
                        letterSpacing: 1,
                      ),
                    ),
                    _StepItem(number: '1', text: i18n.whatsappPremiumStep1),
                    _StepItem(number: '2', text: i18n.whatsappPremiumStep2),
                    _StepItem(number: '3', text: i18n.whatsappPremiumStep3),

                    Container(
                      padding: const EdgeInsets.all(SecretSantaSpacing.md),
                      decoration: BoxDecoration(
                        color: SecretSantaColors.warningBg,
                        borderRadius: BorderRadius.circular(
                          SecretSantaRadius.lg,
                        ),
                        border: Border.all(
                          color: SecretSantaColors.warningBorder,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: SecretSantaSpacing.sm,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: SecretSantaColors.warning,
                            size: 18,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: SecretSantaTextStyles.bodySmall.copyWith(
                                  color: SecretSantaColors.warningText,
                                ),
                                children: [
                                  TextSpan(
                                    text: i18n.whatsappPremiumImportantLabel,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: i18n.whatsappPremiumImportantBody,
                                  ),
                                  TextSpan(
                                    text: i18n.whatsappPremiumUpdatePanel,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const TextSpan(text: '.'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: _openPaymentLink,
                      borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(SecretSantaSpacing.md),
                        decoration: BoxDecoration(
                          gradient: SecretSantaColors.whatsAppGradient,
                          borderRadius: BorderRadius.circular(
                            SecretSantaRadius.xl,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: SecretSantaSpacing.sm,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: Colors.white,
                              size: 18,
                            ),
                            Text(
                              i18n.whatsappPremiumContractButton,
                              style: SecretSantaTextStyles.button.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.pop(true);
                      },
                      borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(SecretSantaSpacing.md),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: SecretSantaColors.neutral300,
                          ),
                          borderRadius: BorderRadius.circular(
                            SecretSantaRadius.xl,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: SecretSantaSpacing.sm,
                          children: [
                            const Icon(
                              Icons.refresh,
                              color: SecretSantaColors.neutral600,
                              size: 18,
                            ),
                            Text(
                              i18n.whatsappPremiumAlreadyPaidButton,
                              style: SecretSantaTextStyles.button.copyWith(
                                color: SecretSantaColors.neutral600,
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
        ),
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String text;
  const _CheckItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: SecretSantaSpacing.sm,
      children: [
        const Icon(
          Icons.check_circle_rounded,
          color: SecretSantaColors.whatsApp,
          size: 18,
        ),
        Expanded(
          child: Text(
            text,
            style: SecretSantaTextStyles.bodySmall.copyWith(
              color: SecretSantaColors.neutral700,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepItem extends StatelessWidget {
  final String number;
  final String text;
  const _StepItem({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: SecretSantaSpacing.sm,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: SecretSantaColors.neutral200,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: SecretSantaTextStyles.labelSmall.copyWith(
              color: SecretSantaColors.neutral700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: SecretSantaTextStyles.bodySmall.copyWith(
              color: SecretSantaColors.neutral700,
            ),
          ),
        ),
      ],
    );
  }
}
