import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_body.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/labeled_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_currency_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_name_form_field.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/group/core/utils/group_validators.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

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
    return FormBody(
      child: Column(
        spacing: SecretSantaSpacing.sm,
        children: [
          LabeledField(
            label: l10n.groupName,
            child: MyNameFormField(
              controller: widget.groupNameController,
              hintText: l10n.groupNameHint,
              icon: Icons.group,
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.next,
            ),
          ),
          Row(
            spacing: SecretSantaSpacing.lg,
            children: [
              Expanded(
                child: LabeledField(
                  label: l10n.minGiftValue,
                  child: MyCurrencyFormField(
                    controller: widget.minGiftValueController,
                    hintText: l10n.minValueHint,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              Expanded(
                child: LabeledField(
                  label: l10n.maxGiftValue,
                  child: MyCurrencyFormField(
                    controller: widget.maxGiftValueController,
                    hintText: l10n.maxValueHint,
                    validator: (_) => GroupValidators.giftValue(
                      context: context,
                      min: widget.minGiftValueController.text,
                      max: widget.maxGiftValueController.text,
                    ),
                    textInputAction: TextInputAction.next,
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
      ),
    );
  }
}
