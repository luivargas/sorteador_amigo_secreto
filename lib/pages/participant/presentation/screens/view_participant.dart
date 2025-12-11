import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/participant_form_field.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class ViewParticipant extends StatefulWidget {
  final String? userId;
  const ViewParticipant({super.key, required this.userId});

  @override
  State<ViewParticipant> createState() => _ViewParticipant();
}

class _ViewParticipant extends State<ViewParticipant> {
  final RefreshController _refreshController = RefreshController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PhoneController phoneController = PhoneController();

  bool _prefilledOnce = false;

  bool readOnly = true;

  Future<void> _onRefresh() async {
    await context.read<ParticipantCubit>().show(widget.userId!);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocConsumer<ParticipantCubit, ParticipantState>(
        listener: (context, state) {
          _prefillFromApi(state);
        },
        builder: (context, state) {
          if (state.showed != true || state.isLoading != false) {
            return const Center(child: CircularProgressIndicator());
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
                            ParticipantFormFields(
                              nameController: nameController,
                              readOnly: readOnly,
                              phoneController: phoneController,
                              emailController: emailController,
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  readOnly = !readOnly;
                                });
                              },
                              child: Text('Editar', style: Theme.of(context).textTheme.titleSmall,),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: MyButton(
                                onTap: () {},
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
    );
  }
}
