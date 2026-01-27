// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/edit_group/edit_group_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class EditGroup extends StatefulWidget {
  final int? groupId;
  const EditGroup({super.key, required this.groupId});

  @override
  State<EditGroup> createState() => _EditGroup();
}

class _EditGroup extends State<EditGroup> {
  final GlobalKey<FormState> _editGroupKey = GlobalKey<FormState>();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController minGiftValueController = TextEditingController();
  final TextEditingController maxGiftValueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  DateTime? _selectedDateTime;

  bool _prefilledOnce = false;

  @override
  void dispose() {
    groupNameController.dispose();
    minGiftValueController.dispose();
    maxGiftValueController.dispose();
    descriptionController.dispose();
    dateTimeController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void _prefillFromApi(GroupState state) {
    if (_prefilledOnce) return;
    if (state.group == null) return;
    final g = state.group!;

    groupNameController.text = g.name;
    descriptionController.text = g.description ?? '';
    locationController.text = g.location ?? '';
    minGiftValueController.text = g.minGiftValue ?? '';
    maxGiftValueController.text = g.maxGiftValue ?? '';
    if (g.drawDate != null && g.drawDate!.isNotEmpty) {
      try {
        // parse do formato da API
        final parsed = DateFormat('dd/MM/yyyy HH:mm').parse(g.drawDate!);
        final dt = DateTime(
          parsed.year,
          parsed.month,
          parsed.day,
          parsed.hour,
          parsed.minute,
        );
        _selectedDateTime = dt;
        dateTimeController.text = g.drawDate!;
      } catch (_) {
        // se der ruim no parse, pelo menos mostra o valor cru
        dateTimeController.text = g.drawDate!;
      }
    } else {
      dateTimeController.text = '';
      _selectedDateTime = null;
    }

    _prefilledOnce = true;
  }

  Future<void> _pickDateTime() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();

    // 1) Data
    var pickedDate = await showDatePicker(
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
    var pickedTime = await showTimePicker(
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
    final isValid = _editGroupKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _editGroupKey.currentState?.save();

    final description = descriptionController.text.trim();
    final groupName = groupNameController.text.trim();
    final minGiftValue = minGiftValueController.text
        .replaceAll(",", ".")
        .replaceAll("R\$", "")
        .trim();
    final maxGiftValue = maxGiftValueController.text
        .replaceAll(",", ".")
        .replaceAll("R\$", "")
        .trim();
    final location = locationController.text.trim();
    DateTime? toSend;
    if (_selectedDateTime != null) {
      toSend = _selectedDateTime!.subtract(const Duration(hours: 3));
    }
    final date = toSend == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(toSend);
    final entity = UpdateGroupEntity(
      description: description,
      name: groupName,
      maxGiftValue: maxGiftValue,
      minGiftValue: minGiftValue,
      location: location,
      drawDate: date,
    );
    context.read<GroupCubit>().update(entity, widget.groupId!);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editGroupKey,
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Theme.of(context).canvasColor,
        body: BlocConsumer<GroupCubit, GroupState>(
          listener: (context, state) {
            _prefillFromApi(state);
            if (state.updated == true) {
              context.pop(true);
            }
          },
          builder: (context, state) {
          while (state.isLoading == true && state.group == null) {
            return Center(
              child: CircularProgressIndicator(
                color: myProgressIndicator.color,
              ),
            );
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
                        minGiftValueController: minGiftValueController,
                        maxGiftValueController: maxGiftValueController,
                        addressController: locationController,
                        onTapDateTime: _pickDateTime,
                      ),
                      MyGradientButton(
                        onTap: () {
                          _onSubmit();
                        },
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
