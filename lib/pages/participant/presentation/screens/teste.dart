// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';

class FlutterContactsExample extends StatefulWidget {
  const FlutterContactsExample({super.key});

  @override
  _FlutterContactsExampleState createState() => _FlutterContactsExampleState();
}

class _FlutterContactsExampleState extends State<FlutterContactsExample> {
  final RefreshController _refreshController = RefreshController();
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _refreshController.dispose();

  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  Future<void> _onRefresh() async {
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(appBar: MyAppBar(), body: _body()),
  );

  Widget _body() {
    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (_contacts == null) return Center(child: CircularProgressIndicator());
    return SmartRefresher(
      onRefresh: () => _onRefresh,
      controller: _refreshController,
      child: ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(_contacts![i].displayName),
          onTap: () async {
            final fullContact = await FlutterContacts.getContact(
              _contacts![i].id,
            );
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ContactPage(fullContact!)),
            );
          },
        ),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;
  const ContactPage(this.contact, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(contact.displayName)),
    body: Column(
      children: [
        Text('Name: ${contact.displayName}'),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (_, _) => Container(),
          itemCount: contact.phones.length,
          itemBuilder: (context, index) {
            final f = contact;
            return Column(
              children: [
                Text(
                  'Phone number ${index + 1}: ${f.phones.isNotEmpty ? f.phones[index].number : '(none)'}',
                ),
              ],
            );
          },
        ),
        Text(
          'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}',
        ),
      ],
    ),
  );
}
