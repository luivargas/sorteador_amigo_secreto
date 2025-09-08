import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

class GroupFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController descriptionController;
  final TextEditingController addressController;

  const GroupFormFields({
    super.key,
    required this.nameController,
    required this.dateController,
    required this.timeController,
    required this.descriptionController,
    required this.minPriceController,
    required this.maxPriceController, required this.addressController,
  });

  @override
  State<GroupFormFields> createState() => _GroupFormFieldsState();
}

class _GroupFormFieldsState extends State<GroupFormFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Nome do Grupo'),
            TextFormField(
              controller: widget.nameController,
              decoration: const InputDecoration(
                hintText: 'Escolha um nome maneiro',
                prefixIcon: Icon(Icons.abc),
                border: OutlineInputBorder(),
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
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        Row(
          spacing: 20,
          children: [
            SizedBox(
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text('Valor Mínimo'),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(casasDecimais: 2, moeda: true),
                    ],
                    controller: widget.minPriceController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(casasDecimais: 2, moeda: true),
                    ],
                    controller: widget.maxPriceController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          spacing: 20,
          children: [
            SizedBox(
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text('Data do evento'),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ],
                    controller: widget.dateController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
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
                  Text('Horário do evento'),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      HoraInputFormatter(),
                    ],
                    controller: widget.timeController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.access_time),
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
            Text('Descrição do Grupo'),
            TextFormField(
              maxLength: 300,
              maxLines: 4,
              controller: widget.descriptionController,
            ),
          ],
        ),
      ],
    );
  }
}
