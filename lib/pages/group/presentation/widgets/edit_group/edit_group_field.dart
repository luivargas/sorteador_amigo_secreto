import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
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
  String? usString;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      spacing: 10,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(l10n.groupName),
            TextFormField(
              validator: (_) => ValidatorUtils.nameValidator(
                context: context,
                v: widget.groupNameController.text,
              ),
              controller: widget.groupNameController,
              decoration: InputDecoration(
                hintText: l10n.groupNameHint,
                prefixIcon: const Icon(Icons.group),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(l10n.eventLocation),
            TextFormField(
              controller: widget.addressController,
              decoration: InputDecoration(
                hintText: l10n.locationHint,
                prefixIcon: const Icon(Icons.place),
              ),
            ),
          ],
        ),
        Row(
          spacing: 20,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(l10n.minGiftValue),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(casasDecimais: 2, moeda: true),
                    ],
                    controller: widget.minGiftValueController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.attach_money),
                      hintText: l10n.minValueHint,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(l10n.maxGiftValue),
                  TextFormField(
                    validator: (_) => ValidatorUtils.giftValue(
                      context: context,
                      min: widget.minGiftValueController.text,
                      max: widget.maxGiftValueController.text,
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(casasDecimais: 2, moeda: true),
                    ],
                    controller: widget.maxGiftValueController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.attach_money),
                      hintText: l10n.maxValueHint,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(l10n.dateAndTime),
            TextFormField(
              controller: widget.dateTimeController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: l10n.dateHint,
                prefixIcon: const Icon(Icons.event),
              ),
              onTap: widget.onTapDateTime,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(l10n.groupDescription),
            TextFormField(
              keyboardType: TextInputType.text,
              maxLines: 4,
              controller: widget.descriptionController,
            ),
          ],
        ),
      ],
    );
  }
}
