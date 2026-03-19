import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart'; 

class EditContactPage extends StatefulWidget {
  final Contact? contact;
  const EditContactPage({super.key, this.contact});
  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  late final _first = TextEditingController(
    text: widget.contact?.name?.first ?? '',
  );
  late final _last = TextEditingController(
    text: widget.contact?.name?.last ?? '',
  );
  late final _phones = (widget.contact?.phones ?? [])
      .map((p) => TextEditingController(text: p.number))
      .toList();
  late final _emails = (widget.contact?.emails ?? [])
      .map((e) => TextEditingController(text: e.address))
      .toList();

  Future<void> _save() async {
    final phones = [
      for (final c in _phones)
        if (c.text.isNotEmpty) Phone(number: c.text),
    ];
    final emails = [
      for (final c in _emails)
        if (c.text.isNotEmpty) Email(address: c.text),
    ];
    final name = Name(first: _first.text, last: _last.text);
    if (widget.contact == null) {
      await FlutterContacts.create(
        Contact(name: name, phones: phones, emails: emails),
      );
    } else {
      await FlutterContacts.update(
        widget.contact!.copyWith(name: name, phones: phones, emails: emails),
      );
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).canvasColor,
    appBar: MyAppBar(
      actions: [IconButton(icon: const Icon(Icons.save), onPressed: _save)], title: "",
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Criar novo contato',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextField(
                    controller: _first,
                    decoration: const InputDecoration(labelText: 'First name'),
                  ),
                ),
                TextField(
                  controller: _last,
                  decoration: const InputDecoration(labelText: 'Last name'),
                ),
                const SizedBox(height: 16),
                _section('Phones', _phones, TextInputType.phone),
                const SizedBox(height: 16),
                _section('Emails', _emails, TextInputType.emailAddress),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _section(
    String title,
    List<TextEditingController> ctrls,
    TextInputType type,
  ) => Column(
    children: [
      Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => ctrls.add(TextEditingController())),
          ),
        ],
      ),
      for (final c in ctrls)
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: TextField(
            controller: c,
            decoration: InputDecoration(
              labelText: title.substring(0, title.length - 1),
            ),
            keyboardType: type,
          ),
        ),
    ],
  );
}
