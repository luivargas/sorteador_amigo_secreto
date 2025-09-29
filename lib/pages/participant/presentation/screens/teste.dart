import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/participant_entity.dart';

class SimpleAdvancedForm extends StatefulWidget {
  const SimpleAdvancedForm({super.key});

  @override
  State<SimpleAdvancedForm> createState() => _SimpleAdvancedFormState();
}

class _SimpleAdvancedFormState extends State<SimpleAdvancedForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _groupName = TextEditingController();
  bool _newsletter = false;

  bool _showAdvanced = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _groupName.dispose();
    super.dispose();
  }

  String? _requiredIfVisible(String? value) {
    if (_showAdvanced && (value == null || value.trim().isEmpty)) {
      return 'Campo obrigatório no modo avançado';
    }
    return null;
  }

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _formKey.currentState?.save();
    final email = _emailCtrl.text;
    final name = _nameCtrl.text;
    final groupName = _groupName.text;
    final entity = CreateGroupEntity(
      name: groupName,
      admin: ParticipantEntity(name: name, email: email),
    );
    getIt<GroupCubit>().create(entity);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Form enviado com sucesso!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário simples/avançado')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- Campos básicos ---
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Informe seu nome' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Informe seu e-mail';
                final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim());
                return ok ? null : 'E-mail inválido';
              },
            ),

            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => setState(() => _showAdvanced = !_showAdvanced),
                icon: Icon(
                  _showAdvanced ? Icons.expand_less : Icons.expand_more,
                ),
                label: Text(_showAdvanced ? 'Mostrar menos' : 'Mostrar mais'),
              ),
            ),

            // --- Bloco avançado com animação e estado preservado ---
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, anim) =>
                  SizeTransition(sizeFactor: anim, child: child),
              child: _showAdvanced
                  ? Column(
                      key: const ValueKey('advanced'),
                      children: [
                        const SizedBox(height: 8),
                        // Visibility com maintainState garante que o que o usuário digitou não se perca ao ocultar
                        Visibility(
                          visible: _showAdvanced,
                          maintainState: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _groupName,
                                decoration: const InputDecoration(
                                  labelText: 'Nome do grupo',
                                  border: OutlineInputBorder(),
                                ),
                                validator: _requiredIfVisible,
                              ),
                              const SizedBox(height: 12),
                              const SizedBox(height: 12),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Quero receber a newsletter'),
                                value: _newsletter,
                                onChanged: (v) => setState(() {
                                  _newsletter = v ?? false;
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),

            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _onSubmit,
              icon: const Icon(Icons.send),
              label: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
