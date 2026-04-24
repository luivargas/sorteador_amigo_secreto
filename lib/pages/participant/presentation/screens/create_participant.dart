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
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/create_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class CreateParticipant extends StatefulWidget {
  const CreateParticipant({
    super.key,
  });

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
    await context.read<ParticipantCubit>().create(entity, group.token,);
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
            child: BlocConsumer<ParticipantCubit, ParticipantState>(
              listenWhen: (prev, curr) => prev.isLoading && !curr.isLoading,
              listener: (context, state) async {
                if (state.created) {
                  AppAlert.showBanner(
                    context,
                    message: l10n.participantAddedSuccess(nameController.text),
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
                          
                      InkWell(
                        borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
                        onTap: () async {
                          final result = await context.pushNamed(
                            'contacts',
                          );
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
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
            ),
          ),
        ),
      ),
    );
  }
}
