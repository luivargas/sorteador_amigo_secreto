import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/network/contants.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/loading_or_error.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/participant_card.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/view_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class ViewParticipant extends StatefulWidget {
  final String userId;
  final String groupToken;
  const ViewParticipant({
    super.key,
    required this.userId,
    required this.groupToken,
  });

  @override
  State<ViewParticipant> createState() => _ViewParticipant();
}

class _ViewParticipant extends State<ViewParticipant> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PhoneController phoneController = PhoneController();
  final GlobalKey<FormState> _validateFormKey = GlobalKey<FormState>();

  bool _prefilledOnce = false;

  bool readOnly = false;

  String? role;

  void _prefillFromApi(ParticipantState state) {
    if (_prefilledOnce) return;
    if (state.showParti == null) return;
    final g = state.showParti!;

    nameController.text = g.name;
    emailController.text = g.email ?? '';
    final idd = g.idd ?? '';
    final rawPhone = g.phone ?? '';
    final fullPhone = idd.isNotEmpty && rawPhone.isNotEmpty
        ? '+$idd$rawPhone'
        : rawPhone;
    phoneController.value = fullPhone.isNotEmpty
        ? PhoneNumber.parse(fullPhone)
        : const PhoneNumber(isoCode: IsoCode.BR, nsn: '');
    _prefilledOnce = true;
    role = g.role;
  }

  Future<void> _onSubmit() async {
    final formState = _validateFormKey.currentState;
    if (formState == null || !formState.validate()) return;

    setState(() {
      readOnly = true;
    });

    final entity = UpdateParticipantEntity(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.value.international,
      idd: phoneController.value.countryCode,
      role: role,
    );
    await context.read<ParticipantCubit>().update(
      entity,
      widget.userId,
      widget.groupToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(
        // title: l10n.participantTitle,
        // subTitle: l10n.participantSubtitle,
      ),
      body: Form(
        key: _validateFormKey,
        child: BlocConsumer<ParticipantCubit, ParticipantState>(
          listener: (context, state) {
            _prefillFromApi(state);
            if (state.error != null) {
              SecretSantaAlertTheme(
                message: state.error!.localize(context),
                type: AlertType.warning,
              );
              setState(() {
                readOnly = false;
              });
            }
            if (state.updated) {
              SecretSantaAlertTheme(
                message: l10n.participantUpdatedSuccess(nameController.text),
                type: AlertType.success,
              );
              if (context.mounted) {
                context.pop(true);
              }
            }
          },
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading ||
              previous.showed != current.showed ||
              previous.error != current.error,
          builder: (context, state) {
            return LoadingOrError(
              isLoading: state.isLoading && !state.showed,
              error: state.error,
              onRetry: () async => await context.read<ParticipantCubit>().show(
                    widget.userId,
                    widget.groupToken,
                  ),
              child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ParticipantCard(
                        image: Image.asset(
                          contactDefaultPhoto,
                          scale: 20,
                        ),
                        button: MyGradientButton(
                          onTap: () {
                            _onSubmit();
                          },
                          title: l10n.save,
                          icon: Icons.save,
                        ),
                        child: ViewParticipantFormFields(
                          nameController: nameController,
                          readOnly: readOnly,
                          phoneController: phoneController,
                          emailController: emailController,
                          participant: state.showParti,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            );
          },
        ),
      ),
    );
  }
}
