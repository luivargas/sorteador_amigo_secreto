import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class GroupFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController groupNameController;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final TextEditingController dateTimeController;
  final TextEditingController descriptionController;
  final TextEditingController addressController;
  final PhoneController phoneController;
  final dynamic onTapDateTime;

  const GroupFormFields({
    super.key,
    required this.groupNameController,
    required this.dateTimeController,
    required this.descriptionController,
    required this.minPriceController,
    required this.maxPriceController,
    required this.addressController,
    required this.nameController,
    required this.emailController,
    required this.phoneController, 
    required this.onTapDateTime,

  });

  @override
  State<GroupFormFields> createState() => _GroupFormFieldsState();
}

class _GroupFormFieldsState extends State<GroupFormFields> {
  String? usString;

  String? _validator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Informe seu e-mail';
    }
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim());
    return ok ? null : 'E-mail inválido';
  }

  bool _showAdvanced = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Seu nome'),
            TextFormField(
              validator: _validator,
              controller: widget.nameController,
              decoration: const InputDecoration(
                hintText: 'Ex: Simba',
                prefixIcon: Icon(Icons.abc),
              ),
            ),
            Text('E-mail'),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: _emailValidator,
              controller: widget.emailController,
              decoration: const InputDecoration(
                hintText: 'Ex: simba@disney.com',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text('DDD + Celular'),
                PhoneFormField(
                  controller: widget.phoneController,
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: PhoneValidator.compose([
                    PhoneValidator.required(
                      context,
                      errorText: "Informe seu telefone",
                    ),
                    PhoneValidator.validMobile(context),
                  ]),
                  countrySelectorNavigator: CountrySelectorNavigator.dialog(
                    backgroundColor: Theme.of(context).canvasColor,
                    titleStyle: myTheme.textTheme.titleSmall,
                    searchBoxTextStyle: myTheme.inputDecorationTheme.labelStyle,
                  ),
                  enabled: true,
                  isCountrySelectionEnabled: true,
                  isCountryButtonPersistent: true,
                  countryButtonStyle: CountryButtonStyle(),
                ),
              ],
            ),
            Text('Nome do Grupo'),
            TextFormField(
              validator: _validator,
              controller: widget.groupNameController,
              decoration: const InputDecoration(
                hintText: 'Ex: Amigo Secreto do Escritório',
                prefixIcon: Icon(Icons.group),
              ),
            ),
            TextButton.icon(
              onPressed: () => setState(() => _showAdvanced = !_showAdvanced),
              icon: Icon(_showAdvanced ? Icons.expand_less : Icons.expand_more),
              label: Text(
                _showAdvanced ? 'Mostrar menos' : 'Preencha mais informações',
              ),
            ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) =>
              SizeTransition(sizeFactor: animation, child: child),
          child: _showAdvanced
              ? Column(
                  key: const ValueKey('advanced'),
                  children: [
                    const SizedBox(height: 8),
                    Visibility(
                      visible: _showAdvanced,
                      maintainState: true,
                      maintainAnimation: true,
                      maintainSize: true,
                      child: Column(
                        spacing: 10,
                        children: [
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
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CentavosInputFormatter(
                                          casasDecimais: 2,
                                          moeda: true,
                                        ),
                                      ],
                                      controller: widget.minPriceController,
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
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CentavosInputFormatter(
                                          casasDecimais: 2,
                                          moeda: true,
                                        ),
                                      ],
                                      controller: widget.maxPriceController,
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
                                maxLength: 300,
                                maxLines: 4,
                                controller: widget.descriptionController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(key: ValueKey('empty')),
        ),
      ],
    );
  }
}
