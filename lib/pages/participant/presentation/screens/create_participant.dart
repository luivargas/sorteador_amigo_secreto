import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/app_alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/screen_padding.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/database/participant_db.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/create_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class CreateParticipant extends StatefulWidget {
  const CreateParticipant({super.key});

  @override
  State<CreateParticipant> createState() => _CreateParticipant();
}

class _CreateParticipant extends State<CreateParticipant> {
  final GlobalKey<FormState> _createFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PhoneController phoneController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.BR, nsn: ''),
  );

  final group = getIt<GroupSession>();
  final _db = getIt<ParticipantDB>();
  bool _alertDismissed = false;

  @override
  void initState() {
    super.initState();
    setState(() => _alertDismissed = _db.isAlertDismissed(group.code));
  }

  Future<void> _dismissAlert() async {
    await _db.dismissAlert(group.code);
    setState(() => _alertDismissed = true);
  }

  Future<void> _onSubmit() async {
    final isValid = _createFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _createFormKey.currentState?.save();

    final entity = CreateParticipantEntity(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.value.international,
      idd: phoneController.value.countryCode,
      role: "participant",
      groupCode: group.code,
    );
    await context.read<ParticipantCubit>().create(entity, group.token);
  }

  Future<void> _onRefresh() async {
    await context.read<GroupCubit>().show(group.code, group.token);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _createFormKey,
      child: Scaffold(
        appBar: MyAppBar(),
        body: SafeArea(
          child: ScreenPadding(
            child: BlocBuilder<GroupCubit, GroupState>(
              buildWhen: (previous, current) => previous.group != current.group,
              builder: (context, state) {
                if (state.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: SecretSantaColors.accent,
                    ),
                  );
                }
                return BlocConsumer<ParticipantCubit, ParticipantState>(
                  listenWhen: (prev, curr) => prev.isLoading && !curr.isLoading,
                  listener: (context, state) async {
                    if (state.created) {
                      AppAlert.showBanner(
                        context,
                        message: l10n.participantAddedSuccess(
                          nameController.text,
                        ),
                        type: AlertType.success,
                      );
                      await Future.delayed(const Duration(milliseconds: 600));
                      if (context.mounted) {
                        context.pop(true);
                      }
                    }
                    if (state.error != null) {
                      if (context.mounted) {
                        AppAlert.showBanner(
                          context,
                          title: l10n.errorTitle,
                          message: state.error!.localize(context),
                          type: AlertType.warning,
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Column(
                        spacing: SecretSantaSpacing.sm,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                l10n.addParticipantTitle,
                                style: SecretSantaTextStyles.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                l10n.addParticipantSubtitle,
                                style: SecretSantaTextStyles.body,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          group.whatsappEnabled
                              ? _ContactsCard()
                              : _WhatsAppCard(
                                  code: group.code,
                                  onRefresh: _onRefresh,
                                ),
                          Column(
                            spacing: SecretSantaSpacing.lg,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CreateParticipantFormFields(
                                nameController: nameController,
                                emailController: emailController,
                                phoneController: phoneController,
                              ),
                              if (!group.whatsappEnabled && !_alertDismissed)
                                _WhatsAppAlert(onDismiss: _dismissAlert),
                              MyGradientButton(
                                onTap: _onSubmit,
                                title: l10n.addParticipantButton,
                                icon: Icons.save,
                                isLoading: state.isLoading,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
      onTap: () async {
        final result = await context.pushNamed('contacts');
        if (result == true && context.mounted) {
          context.pop(true);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          gradient: SecretSantaColors.primaryGradient,
          borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: SecretSantaColors.neutral50,
            borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
            boxShadow: SecretSantaShadows.medium,
          ),
          child: Padding(
            padding: const EdgeInsets.all(SecretSantaSpacing.lg),
            child: Row(
              spacing: SecretSantaSpacing.md,
              children: [
                Icon(Icons.contact_page),
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.quickAccess,
                            style: TextStyle(
                              color: SecretSantaColors.accent2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            l10n.importContacts,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: SecretSantaColors.accent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WhatsAppCard extends StatelessWidget {
  final String code;
  final Function() onRefresh;
  const _WhatsAppCard({required this.code, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      splashColor: SecretSantaColors.whatsApp.withValues(alpha: 0.2),
      highlightColor: SecretSantaColors.whatsApp.withValues(alpha: 0.1),
      onTap: () async {
        final result = await context.pushNamed('whatsapp_premium');
        if (result == true) {
          if (context.mounted) {
            onRefresh();
          }
        }
      },
      borderRadius: BorderRadius.circular(SecretSantaRadius.lg),
      child: Ink(
        padding: const EdgeInsets.all(SecretSantaSpacing.md),
        decoration: BoxDecoration(
          gradient: SecretSantaColors.whatsAppGradient,
          borderRadius: BorderRadius.circular(SecretSantaRadius.lg),
          boxShadow: SecretSantaShadows.small,
        ),
        child: Row(
          children: [
            Center(
              child: FaIcon(
                FontAwesomeIcons.whatsapp,
                color: SecretSantaColors.neutral50,
                size: 35,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.whatsappPremiumTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: SecretSantaColors.neutral50,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    l10n.whatsappPremiumCardSubtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: SecretSantaColors.neutral50,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: SecretSantaColors.neutral50),
          ],
        ),
      ),
    );
  }
}

class _WhatsAppAlert extends StatelessWidget {
  final VoidCallback onDismiss;
  const _WhatsAppAlert({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(SecretSantaSpacing.md),
      decoration: BoxDecoration(
        color: SecretSantaColors.warningBg,
        borderRadius: BorderRadius.circular(SecretSantaRadius.lg),
        border: Border.all(color: SecretSantaColors.warningBorder),
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
                    text: '${l10n.whatsappPremiumAlertStart}. ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: l10n.whatsappPremiumAlertEnd),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onDismiss,
            borderRadius: BorderRadius.circular(SecretSantaRadius.full),
            child: const Icon(
              Icons.close,
              color: SecretSantaColors.warning,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
