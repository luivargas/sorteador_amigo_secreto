import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/view_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class ViewParticipant extends StatefulWidget {
  final String userId;
  final String groupToken;
  const ViewParticipant({super.key, required this.userId, required this.groupToken});

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

  bool readOnly = true;

  Future<void> _onRefresh() async {
    await context.read<ParticipantCubit>().show(widget.userId, widget.groupToken);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _prefillFromApi(ParticipantState state) {
    if (_prefilledOnce) return;
    if (state.participant == null) return;
    final g = state.participant!;

    nameController.text = g.name;
    emailController.text = g.email ?? '';
    final phone = g.phone ?? '';
    phoneController.value = PhoneNumber(isoCode: IsoCode.BR, nsn: phone);
    _prefilledOnce = true;
  }

  void _onSubmit() {
    if (_validadeFormKey.currentState!.validate()) {}
    final isValid = _validadeFormKey.currentState?.validate() ?? false;
    if (!isValid) return;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _validadeFormKey,
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Theme.of(context).canvasColor,
        body: BlocConsumer<ParticipantCubit, ParticipantState>(
          listener: (context, state) {
            _prefillFromApi(state);
          },
          builder: (context, state) {
            if (state.showed != true || state.isLoading != false) {
              return Center(
                child: CircularProgressIndicator(
                  color: myProgressIndicator.color,
                ),
              );
            }
            if (state.error != null) {
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: Center(child: Text("Tente novamente")),
              );
            }
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
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
                                participant: state.participant!,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    readOnly = !readOnly;
                                  });
                                },
                                child: Text(
                                  'Editar',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: MyButton(
                                  onTap: _onSubmit,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
