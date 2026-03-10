import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});
  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final Set<String> _selectedContacts = {};
  List<Contact>? _contacts;
  StreamSubscription? _sub;
  bool _denied = false;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  bool _hasName(Contact c) => (c.displayName ?? "").trim().isNotEmpty;

  bool _hasPhone(Contact c) => c.phones.isNotEmpty;

  bool _hasEmail(Contact c) => c.emails.isNotEmpty;

  bool _isContactValid(Contact c) => _hasName(c) && (_hasPhone(c) || _hasEmail(c));

  Future<void> _loadContacts() async {
    final s = await FlutterContacts.permissions.request(
      PermissionType.readWrite,
    );
    if (s != PermissionStatus.granted && s != PermissionStatus.limited) {
      return setState(() => _denied = true);
    }
    _sub = FlutterContacts.onContactChange.listen((changes) {
      for (final c in changes) {
        print('Contact ${c.type.name}: ${c.contactId}'); // ignore: avoid_print
      }
      _load();
    });
    _load();
  }

  Future<void> _load() async {
    final contacts = await FlutterContacts.getAll(
      properties: {
        ContactProperty.photoThumbnail,
        ContactProperty.name,
        ContactProperty.email,
        ContactProperty.phone,
      },
    );
    contacts.sort(
      (a, b) => (a.displayName ?? "").compareTo(b.displayName ?? ""),
    );
    setState(() => _contacts = contacts);
  }

  void _toggleSelection(Contact c) {
    if (!_isContactValid(c)) {
      AppAlert.show(
        context,
        message: "Este contato precisa ter nome e telefone",
      );
      return;
    }

    setState(() {
      if (_selectedContacts.contains(c.id)) {
        _selectedContacts.remove(c.id);
      } else {
        _selectedContacts.add(c.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).canvasColor,
    appBar: MyAppBar(),
    body: Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: Column(
        spacing: 10,
        children: [
          Text(
            "Lista de Contatos",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text("Selecionados: ${_selectedContacts.length}"),
          if (_denied)
            const Center(child: Text("Permissão de contato não concedida"))
          else if (_contacts == null)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: ListView.builder(
                itemCount: _contacts!.length,
                itemBuilder: (_, i) {
                  final c = _contacts![i];
              
                  final hasName = _hasName(c);
                  final hasPhone = _hasPhone(c);
                  final hasEmail = _hasEmail(c);
                  final isValid = _isContactValid(c);
                  final selected = _selectedContacts.contains(c.id);
              
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: selected
                              ? MyColors.sorteadorOrange
                              : null,
                                      
                          leading: CircleAvatar(
                            backgroundImage: c.photo?.thumbnail != null
                                ? MemoryImage(c.photo!.thumbnail!)
                                : null,
                            child: c.photo?.thumbnail == null
                                ? const Icon(Icons.person)
                                : null,
                          ),
                          title: Text(
                            c.displayName ?? '',
                            style: TextStyle(
                              color: selected ? Colors.white : (isValid ? null : Colors.red),
                              fontWeight: isValid
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                          subtitle: !isValid
                             ? Text("${[
                              if(!hasName) "Nome",
                              if(!hasPhone && !hasEmail) "Telefone",
                             ].join(", ")} Obrigatório", style: const TextStyle(color: Colors.red),)
                             :null,
                          trailing: GestureDetector(
                            onTap: () => _toggleSelection(c),
                            child: Icon(
                              selected
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: _selectedContacts.contains(c.id)
                                  ? Colors.white
                                  : MyColors.sorteadorOrange,
                            ),
                          ),
                          onTap: () => context.push('/contact_page/${c.id}'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    ),

    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => context.push('/edit_contact_page'),
    ),
  );
}
