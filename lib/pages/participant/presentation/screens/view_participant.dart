import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/loading_or_error.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/participant_card.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/view_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

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

  String image = "./assets/logos/icons/Logo_9.png";

  void _prefillFromApi(ParticipantState state) {
    if (_prefilledOnce) return;
    if (state.showParti == null) return;
    final g = state.showParti!;

    nameController.text = g.name;
    emailController.text = g.email ?? '';
    phoneController.value = PhoneNumber(
      isoCode: IsoCode.AC,
      nsn: g.phone ?? '',
    );
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
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Theme.of(context).canvasColor,
      body: Form(
        key: _validateFormKey,
        child: BlocConsumer<ParticipantCubit, ParticipantState>(
          listener: (context, state) {
            _prefillFromApi(state);
            if (state.error != null) {
              AppAlert.show(
                context,
                message: state.error!,
                type: AlertType.error,
              );
              setState(() {
                readOnly = false;
              });
            }
            if (state.updated) {
              AppAlert.show(
                context,
                message: AppLocalizations.of(context)!.participantUpdatedSuccess(nameController.text),
                type: AlertType.success,
              );
              if (context.mounted) {
                context.pop(true);
              }
            }
          },
          buildWhen: (previous, current) =>
              previous.isLoading && !previous.showed,
          builder: (context, state) {
            return LoadingOrError(
              isLoading: state.isLoading && !state.showed,
              error: state.error,
              child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.participantTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ParticipantCard(
                        image: Image.asset(
                          image,
                          scale: 20,
                        ),
                        button: MyGradientButton(
                          onTap: () {
                            _onSubmit();
                          },
                          title: AppLocalizations.of(context)!.save,
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
