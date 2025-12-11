import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/participant_form_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class ParticipantForm extends StatefulWidget {
  final String? groupId;
  final String? groupCode;
  const ParticipantForm({super.key, this.groupId, this.groupCode});

  @override
  State<ParticipantForm> createState() => _ParticipantForm();
}

class _ParticipantForm extends State<ParticipantForm> {
  bool isAdmin = false;
  Color activeColor = MyColors.sorteadorOrange;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PhoneController phoneController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.BR, nsn: ''),
  );

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _formKey.currentState?.save();
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
      role: isAdmin ? "admin" : "participant",
      groupCode: widget.groupCode,
    );
    context.read<ParticipantCubit>().create(entity, int.parse(widget.groupId!));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
              return const Center(child: CircularProgressIndicator());
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
                      ParticipantFormFields(
                        nameController: nameController,
                        emailController: emailController,
                        phoneController: phoneController, readOnly: false,
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
