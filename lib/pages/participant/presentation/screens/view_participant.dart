import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/view_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart'
    hide AlertType;
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

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
  final RefreshController _refreshController = RefreshController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PhoneController phoneController = PhoneController();
  final GlobalKey<FormState> _validadeFormKey = GlobalKey<FormState>();

  bool _prefilledOnce = false;

  bool readOnly = false;

  Future<void> _onRefresh() async {
    await context.read<ParticipantCubit>().show(
      widget.userId,
      widget.groupToken,
    );
  }

  String? role;

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
    final formState = _validadeFormKey.currentState;
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
        key: _validadeFormKey,
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
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
              if (state.updated == true) {
                AppAlert.show(
                  context,
                  message:
                      'Participante ${nameController.text} atualisado com sucesso!',
                  type: AlertType.success,
                );
                if (context.mounted) {
                  context.pop(true);
                }
              }
            },
            buildWhen: (previous, current) =>
                previous.isLoading == true &&
                previous.showed == false,
            builder: (context, state) {
              if (state.isLoading == true && state.showed == false) {
                return Center(
                  child: CircularProgressIndicator(
                    color: myProgressIndicator.color,
                  ),
                );
              }
              if (state.error != null) {
                return Center(child: Text("Tente novamente!"));
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Participante',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: SecretSantaColors.neutral50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: MyColors.sorteadorOrange,
                            width: 1,
                          ),
                          boxShadow: SecretSantaShadows.medium,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            20.0,
                            20.0,
                            20.0,
                            20.0,
                          ),
                          child: Column(
                            spacing: 15,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                  color: Theme.of(context).canvasColor,
                                  border: Border.all(
                                    color: MyColors.sorteadorOrange,
                                    width: 1,
                                  ),
                                ),
                                child: Image.asset(
                                  "./assets/logos/icons/Logo_9.png",
                                  scale: 25,
                                ),
                              ),
                              ViewParticipantFormFields(
                                nameController: nameController,
                                readOnly: readOnly,
                                phoneController: phoneController,
                                emailController: emailController,
                                participant: state.showParti,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  20,
                                  20,
                                  20,
                                ),
                                child: MyGradientButton(
                                  onTap: () {
                                    _onSubmit();
                                  },
                                  title: "Salvar",
                                  icon: Icons.save,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
