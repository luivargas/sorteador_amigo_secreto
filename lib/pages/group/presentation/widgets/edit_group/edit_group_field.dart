import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:sorteador_amigo_secreto/core/util/validators_utils.dart';

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
    return Column(
      spacing: 10,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Nome do Grupo'),
            TextFormField(
              validator: (_) => ValidatorUtils.nameValidator(
                v: widget.groupNameController.text,
              ),
              controller: widget.groupNameController,
              decoration: const InputDecoration(
                hintText: 'Ex: Amigo Secreto do Escritório',
                prefixIcon: Icon(Icons.group),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Local do Evento'),
            TextFormField(
              controller: widget.addressController,
              decoration: const InputDecoration(
                hintText: 'Escolha um local',
                prefixIcon: Icon(Icons.place),
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
                  Text('Valor Mínimo'),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(casasDecimais: 2, moeda: true),
                    ],
                    controller: widget.minGiftValueController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      hintText: 'Ex: R\$ 100,00',
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
                  Text('Valor Máximo'),
                  TextFormField(
                    validator: (_) => ValidatorUtils.giftValue(
                      min: widget.minGiftValueController.text,
                      max: widget.maxGiftValueController.text,
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(casasDecimais: 2, moeda: true),
                    ],
                    controller: widget.maxGiftValueController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      hintText: 'Ex: R\$ 150,00',
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
            Text('Date e Hora'),
            TextFormField(
              controller: widget.dateTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'dd/mm/aaaa hh:mm',
                prefixIcon: Icon(Icons.event),
              ),
              onTap: widget.onTapDateTime,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Descrição do Grupo'),
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
