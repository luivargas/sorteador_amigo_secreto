import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/labeled_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_currency_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_name_form_field.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class EditGroupFields extends StatefulWidget {
  final TextEditingController groupNameController;
  final TextEditingController minGiftValueController;
  final TextEditingController maxGiftValueController;
  final TextEditingController dateTimeController;
  final TextEditingController descriptionController;
  final TextEditingController addressController;
  final dynamic onTapDateTime;

  const EditGroupFields({
    super.key,
    required this.groupNameController,
    required this.dateTimeController,
    required this.descriptionController,
    required this.minGiftValueController,
    required this.maxGiftValueController,
    required this.addressController,
    required this.onTapDateTime,
  });

  @override
  State<EditGroupFields> createState() => _EditGroupFields();
}

class _EditGroupFields extends State<EditGroupFields> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      spacing: 10,
      children: [
        LabeledField(
          label: l10n.groupName,
          child: MyNameFormField(
            controller: widget.groupNameController,
            hintText: l10n.groupNameHint,
            icon: Icons.group,
          ),
        ),
        LabeledField(
          label: l10n.eventLocation,
          child: TextFormField(
            controller: widget.addressController,
            decoration: InputDecoration(
              hintText: l10n.locationHint,
              prefixIcon: const Icon(Icons.place),
            ),
          ),
        ),
        Row(
          spacing: 20,
          children: [
            Expanded(
              child: LabeledField(
                label: l10n.minGiftValue,
                child: MyCurrencyFormField(
                  controller: widget.minGiftValueController,
                  hintText: l10n.minValueHint,
                ),
              ),
            ),
            Expanded(
              child: LabeledField(
                label: l10n.maxGiftValue,
                child: MyCurrencyFormField(
                  controller: widget.maxGiftValueController,
                  hintText: l10n.maxValueHint,
                  validator: (_) => ValidatorUtils.giftValue(
                    context: context,
                    min: widget.minGiftValueController.text,
                    max: widget.maxGiftValueController.text,
                  ),
                ),
              ),
            ),
          ],
        ),
        LabeledField(
          label: l10n.dateAndTime,
          child: TextFormField(
            controller: widget.dateTimeController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: l10n.dateHint,
              prefixIcon: const Icon(Icons.event),
            ),
            onTap: widget.onTapDateTime,
          ),
        ),
        LabeledField(
          label: l10n.groupDescription,
          child: TextFormField(
            keyboardType: TextInputType.text,
            maxLines: 4,
            controller: widget.descriptionController,
          ),
        ),
      ],
    );
  }
}
