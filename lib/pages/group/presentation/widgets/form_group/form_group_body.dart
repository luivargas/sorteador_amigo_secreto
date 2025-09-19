import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/form_group/group_form_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class FormGroupBody extends StatefulWidget {
  const FormGroupBody({super.key});

  @override
  State<FormGroupBody> createState() => _FormGroupBody();
}

class _FormGroupBody extends State<FormGroupBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController(
    text: UtilBrasilFields.obterReal(50.000),
  );
  final TextEditingController maxPriceController = TextEditingController(
    text: UtilBrasilFields.obterReal(50.000),
  );
  final TextEditingController dateController = TextEditingController(
    text: UtilData.obterDataDDMMAAAA(DateTime.now()),
  );
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController(
    text: UtilData.obterHoraHHMM(DateTime.now()),
  );
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                  Text('Crie seu Grupo', style: myTheme.textTheme.titleSmall),
                  GroupFormFields(
                    nameController: nameController,
                    dateController: dateController,
                    timeController: timeController,
                    descriptionController: descriptionController,
                    minPriceController: minPriceController,
                    maxPriceController: maxPriceController,
                    addressController: addressController,
                  ),
                  MyButton(onTap: (){}, title: "Criar grupo", icon: Icons.create),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
