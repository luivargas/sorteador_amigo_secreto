// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/components/my_button.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/edit_group/edit_group_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class EditGroup extends StatefulWidget {
  final String? groupId;
  const EditGroup({super.key, required this.groupId});

  @override
  State<EditGroup> createState() => _EditGroup();
}

class _EditGroup extends State<EditGroup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  DateTime? _selectedDateTime;

  bool _prefilledOnce = false;

  @override
  void dispose() {
    groupNameController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    descriptionController.dispose();
    dateTimeController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void _prefillFromApi(GroupState state) {
    if (_prefilledOnce) return;
    final g = state.group!;

    groupNameController.text = g.name;
    descriptionController.text = g.description ?? '';
    locationController.text = g.location ?? '';
    minPriceController.text = g.minGiftValue ?? '';
    maxPriceController.text = g.maxGiftValue ?? '';
    dateTimeController.text = g.drawDate ?? '';
    _prefilledOnce = true;
  }

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
      pickedTime.hour,
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
    final description = descriptionController.text.trim();
    final groupName = groupNameController.text.trim();
    final minPrice = minPriceController.text
        .replaceAll(",", ".")
        .replaceAll("R\$", "")
        .trim();
    final maxPrice = maxPriceController.text
        .replaceAll(",", ".")
        .replaceAll("R\$", "")
        .trim();
    final location = locationController.text.trim();
    final date = _selectedDateTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(_selectedDateTime!);
    final entity = UpdateGroupEntity(
      description: description,
      name: groupName,
      maxGiftValue: maxPrice,
      minGiftValue: minPrice,
      location: location,
      drawDate: date,
    );
    getIt<GroupCubit>().update(entity, int.parse(widget.groupId!));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Theme.of(context).canvasColor,
        body: BlocConsumer<GroupCubit, GroupState>(
          listener: (context, state) {
            _prefillFromApi(state);
          },
          builder: (context, state) {
            if (state.showed != true || state.isLoading != false) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('Tente novamente'));
            }
            return SingleChildScrollView(
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
                        'Edição do grupo!',
                        style: myTheme.textTheme.titleSmall,
                      ),
                      EditGroupFields(
                        groupNameController: groupNameController,
                        dateTimeController: dateTimeController,
                        descriptionController: descriptionController,
                        minPriceController: minPriceController,
                        maxPriceController: maxPriceController,
                        addressController: locationController,
                        onTapDateTime: _pickDateTime,
                      ),
                      MyButton(
                        onTap: _onSubmit,
                        title: "Salvar",
                        icon: Icons.save,
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
