// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/participant_form_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class ParticipantForm extends StatefulWidget {
  final String? groupId;
  const ParticipantForm({super.key, required this.groupId});

  @override
  State<ParticipantForm> createState() => _ParticipantForm();
}

class _ParticipantForm extends State<ParticipantForm> {
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
    );
    getIt<ParticipantCubit>().create(entity, int.parse(widget.groupId!) );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Theme.of(context).canvasColor,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 50),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adicionar participante',
                    style: myTheme.textTheme.titleSmall,
                  ),
                  ParticipantFormFields(
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
        ),
      ),
    );
  }
}
