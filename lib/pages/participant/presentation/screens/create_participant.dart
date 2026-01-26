import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/create_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class CreateParticipant extends StatefulWidget {
  final String groupId;
  final String groupCode;
  const CreateParticipant({super.key, required this.groupId, required this.groupCode});

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
    context.read<ParticipantCubit>().create(entity, int.parse(widget.groupId));
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
              prev.isLoading == true &&
              curr.isLoading == false &&
              curr.created == true,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Participante ${nameController.text} adicionado com sucesso!',
                ),
                showCloseIcon: true,
              ),
            );
            context.pop(true);
          },
          builder: (context, state) {
            if (state.isLoading == true) {
              return Center(child: CircularProgressIndicator(color: myProgressIndicator.color,));
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
