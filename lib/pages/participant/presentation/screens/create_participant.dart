import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/dialog.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/create_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class CreateParticipant extends StatefulWidget {
  final int groupId;
  final String groupCode;
  const CreateParticipant({
    super.key,
    required this.groupId,
    required this.groupCode,
  });

  @override
  State<CreateParticipant> createState() => _CreateParticipant();
}

class _CreateParticipant extends State<CreateParticipant> {
  Color activeColor = MyColors.sorteadorOrange;
  final GlobalKey<FormState> _createFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PhoneController phoneController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.BR, nsn: ''),
  );

  void _onSubmit() {
    if (_createFormKey.currentState!.validate()) {}
    final isValid = _createFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _createFormKey.currentState?.save();
    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final idd = phoneController.value.countryCode.trim();
    final phone = phoneController.value.international.trim().replaceFirst(
      '+$idd',
      '',
    );
    final entity = CreateParticipantEntity(
      name: name,
      email: email,
      phone: phone,
      idd: idd,
      role: "participant",
      groupCode: widget.groupCode,
    );
    context.read<ParticipantCubit>().create(entity, widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createFormKey,
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Theme.of(context).canvasColor,
        body: BlocConsumer<ParticipantCubit, ParticipantState>(
          listenWhen: (prev, curr) =>
              prev.isLoading == true && curr.isLoading == false,
          listener: (context, state) async {
            if (state.created == true) {
              // ✅ SUCESSO
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Participante ${nameController.text} adicionado com sucesso!',
                  ),
                  showCloseIcon: true,
                  backgroundColor: Colors.green,
                ),
              );
              context.pop(true);
            }

            if (state.error != null) {
              // ❌ ERRO
              await AppDialog.show(
                context: context,
                title: 'Erro',
                message: state.error!,
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading == true) {
              return Center(
                child: CircularProgressIndicator(
                  color: myProgressIndicator.color,
                ),
              );
            }
            if (state.error != null) {
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 50),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Adicionar participante',
                        style: myTheme.textTheme.titleSmall,
                      ),
                      CreateParticipantFormFields(
                        nameController: nameController,
                        emailController: emailController,
                        phoneController: phoneController,
                      ),
                      MyButton(
                        onTap: _onSubmit,
                        title: "Adicionar participante",
                        icon: Icons.create,
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
