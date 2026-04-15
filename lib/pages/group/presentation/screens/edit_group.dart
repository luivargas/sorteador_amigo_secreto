// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/loading_or_error.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/core/utils/date_time_utils.dart';
import 'package:sorteador_amigo_secreto/pages/group/core/utils/gift_utils.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/edit_group/edit_group_field.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class EditGroup extends StatefulWidget {
  final String code;
  final String token;
  const EditGroup({super.key, required this.code, required this.token});

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
    minGiftValueController.text = GiftUtils.toDisplayFormat(g.minGiftValue);
    maxGiftValueController.text = GiftUtils.toDisplayFormat(g.maxGiftValue);
    final parsed = DateTimeUtils.fromApi(g.drawDate);
    if (parsed != null) {
      _selectedDateTime = parsed;
      dateTimeController.text = DateTimeUtils.toDisplay(parsed);
    }

    _prefilledOnce = true;
  }

  Future<void> _pickDateTime() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();

    final l10n = AppLocalizations.of(context)!;
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 3),
      helpText: l10n.selectDate,
      cancelText: l10n.cancel,
      confirmText: l10n.ok,
    );

    if (pickedDate == null) return;
    if (!mounted) return;

    var pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: _selectedDateTime == null
          ? TimeOfDay.fromDateTime(now)
          : TimeOfDay.fromDateTime(_selectedDateTime!),
      helpText: l10n.selectTime,
      cancelText: l10n.cancel,
      confirmText: l10n.ok,
    );
    if (pickedTime == null) return;
    if (!mounted) return;

    final dt = DateTimeUtils.combine(pickedDate, pickedTime);
    dateTimeController.text = DateTimeUtils.toDisplay(dt);
    setState(() => _selectedDateTime = dt);
  }

  void _onSubmit() {
    final isValid = _editGroupKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _editGroupKey.currentState?.save();

    final description = descriptionController.text.trim();
    final groupName = groupNameController.text.trim();
    final giftValue = GiftUtils.resolveMinMax(
      minGiftValueController.text,
      maxGiftValueController.text,
    );
    final location = locationController.text.trim();
    DateTime? toSend;
    if (_selectedDateTime != null) {
      toSend = _selectedDateTime!.subtract(const Duration(hours: 3));
    }
    final date = toSend == null
        ? null
        : DateTimeUtils.toApi(_selectedDateTime!);
    final entity = UpdateGroupEntity(
      description: description,
      name: groupName,
      minGiftValue: giftValue.min.isEmpty ? null : giftValue.min,
      maxGiftValue: giftValue.max.isEmpty ? null : giftValue.max,
      location: location,
      drawDate: date,
    );
    context.read<GroupCubit>().update(entity, widget.code, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _editGroupKey,
      child: Scaffold(
        appBar: MyAppBar(),
        body: BlocConsumer<GroupCubit, GroupState>(
          listener: (context, state) {
            _prefillFromApi(state);
            if (state.updated) {
              context.pop(true);
            }
          },
          builder: (context, state) {
            return LoadingOrError(
              isLoading: state.isLoading && state.group == null,
              error: state.error,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 50),
                  child: Column(
                    spacing: 30,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            Text(
                              l10n.editGroupTitle,
                              style: SecretSantaTextStyles.titleMedium,
                            ),
                            Text(
                              l10n.editGroupSubtitle,
                              style: TextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
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
                        onTap: _onSubmit,
                        title: AppLocalizations.of(context)!.save,
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
