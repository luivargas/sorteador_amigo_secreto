import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/create_form_group/group_form_field.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _FormGroupBody();
}

class _FormGroupBody extends State<CreateGroup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PhoneController phoneController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.BR, nsn: ''),
  );
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  DateTime? _selectedDateTime;

  Future<void> _pickDateTime() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();

    // 1) Data
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? now,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year + 5),
      locale: const Locale('pt', 'BR'),
      helpText: 'Selecione a data',
      cancelText: 'Cancelar',
      confirmText: 'OK',
    );
    if (pickedDate == null) return;

    // 2) Hora
    final pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      // ignore: use_build_context_synchronously
      context: context,
      initialTime: _selectedDateTime == null
          ? TimeOfDay.fromDateTime(now)
          : TimeOfDay.fromDateTime(_selectedDateTime!),
      helpText: 'Selecione o horário',
      cancelText: 'Cancelar',
      confirmText: 'OK',
    );
    if (pickedTime == null) return;

    // 3) Combina e atualiza
    final dt = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour - 3,
      pickedTime.minute,
    );

    // mostra no campo em pt-BR
    dateTimeController.text = DateFormat(
      'dd/MM/yyyy HH:mm',
      'pt_BR',
    ).format(dt);

    // guarda o valor cru
    setState(() => _selectedDateTime = dt);
  }

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _formKey.currentState?.save();
    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final groupName = groupNameController.text.trim();
    final idd = phoneController.value.countryCode.trim();
    final phone = phoneController.value.international.trim().replaceFirst(
      '+$idd',
      '',
    );
    final minPrice = minPriceController.text
        .replaceAll(",", ".")
        .replaceAll("R\$", "")
        .trim();
    final maxPrice = maxPriceController.text
        .replaceAll(",", ".")
        .replaceAll("R\$", "")
        .trim();
    final location = locationController.text.trim();
    DateTime? toSend;
    if (_selectedDateTime != null) {
      // aqui você gera a data que será enviada pro back (3h a menos)
      toSend = _selectedDateTime!.subtract(const Duration(hours: 3));
    }
    final date = toSend == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(toSend);
    final entity = CreateGroupEntity(
      name: groupName,
      maxGiftValue: maxPrice,
      minGiftValue: minPrice,
      location: location,
      drawDate: date,
      description: descriptionController.text.trim(),
      admin: CreateParticipantEntity(
        name: name,
        email: email,
        phone: phone,
        idd: idd,
      ),
    );
    context.read<GroupCubit>().create(entity);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: MyAppBar(),
        body: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 300,
            maxWidth: 600,
            minHeight: 400,
            maxHeight: 800,
          ),
          child: SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Crie seu grupo agora!',
                      style: myTheme.textTheme.titleSmall,
                    ),
                    GroupFormFields(
                      groupNameController: groupNameController,
                      dateTimeController: dateTimeController,
                      descriptionController: descriptionController,
                      minPriceController: minPriceController,
                      maxPriceController: maxPriceController,
                      addressController: locationController,
                      nameController: nameController,
                      emailController: emailController,
                      phoneController: phoneController,
                      onTapDateTime: _pickDateTime,
                    ),
                    MyButton(
                      onTap: _onSubmit,
                      title: "Criar grupo",
                      icon: Icons.create,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
