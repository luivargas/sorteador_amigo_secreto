import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/dialog.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/create_parti_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/create_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class CreateParticipant extends StatefulWidget {
  final String groupToken;
  final String groupCode;
  const CreateParticipant({
    super.key,
    required this.groupToken,
    required this.groupCode,
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
      groupCode: widget.groupCode,
    );
    await context.read<ParticipantCubit>().create(entity, widget.groupToken);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _createFormKey,
      child: Scaffold(
        appBar: MyAppBar(),
        body: BlocConsumer<ParticipantCubit, ParticipantState>(
          listenWhen: (prev, curr) => prev.isLoading && !curr.isLoading,
          listener: (context, state) async {
            if (state.created) {
              AppAlert.show(
                context,
                message: AppLocalizations.of(
                  context,
                )!.participantAddedSuccess(nameController.text),
                type: AlertType.success,
              );
              if (context.mounted) {
                context.pop(true);
              }
            }
            if (state.error != null) {
              await AppDialog.show(
                context: context,
                title: l10n.errorTitle,
                message: state.error!.localize(context),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 30,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: SecretSantaColors.neutral50,
                            border: Border.all(
                              color: SecretSantaColors.accent2.withValues(
                                alpha: 0.3,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(Icons.person_add_alt_1, size: 30),
                          ),
                        ),
                        Text(
                          l10n.addParticipantTitle,
                          style: SecretSantaTextStyles.titleMedium,
                        ),
                        Text(
                          l10n.addParticipantSubtitle,
                          style: TextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => context.pushNamed(
                        'contacts',
                        extra: CreateParticipantArgs(
                          groupToken: widget.groupToken,
                          groupCode: widget.groupCode,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          gradient: SecretSantaColors.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: SecretSantaColors.neutral50,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: SecretSantaShadows.medium,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              spacing: 15,
                              children: [
                                Icon(Icons.contact_page),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(l10n.quickAccess, style: TextStyle(color: SecretSantaColors.accent2, fontWeight: FontWeight.w600),),
                                          Text(l10n.importContacts, style: const TextStyle(fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded, color: SecretSantaColors.accent,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CreateParticipantFormFields(
                          nameController: nameController,
                          emailController: emailController,
                          phoneController: phoneController,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: MyGradientButton(
                            onTap: _onSubmit,
                            title: AppLocalizations.of(
                              context,
                            )!.addParticipantButton,
                            icon: Icons.save,
                            isLoading: state.isLoading,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
