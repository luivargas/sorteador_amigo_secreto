import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/edit_contact_page.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/participant_card.dart';

class ContactPage extends StatefulWidget {
  final String id;
  const ContactPage({super.key, required this.id});
  @override
  State<ContactPage> createState() => _ContactPage();
}

class _ContactPage extends State<ContactPage> {
  Future<Contact?> _load() => FlutterContacts.get(
    widget.id,
    properties: {
      ContactProperty.name,
      ContactProperty.phone,
      ContactProperty.email,
      ContactProperty.photoThumbnail,
      ContactProperty.photoFullRes,
    },
  );

  String? getInitials(String? name) {
    if (name == null || name.trim().isEmpty) {
      return null;
    }
    final parts = name.trim().split(" ");
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Contact?>(
    future: _load(),
    builder: (context, snap) {
      final c = snap.data;
      final photo = c?.photo?.fullSize ?? c?.photo?.thumbnail;
      return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: MyAppBar(
          actions: [
            if (c != null)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditContactPage(contact: c),
                  ),
                ),
              ),
          ], title: '',
        ),
        body: c == null
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  ParticipantCard(
                    image: CircleAvatar(
                      backgroundColor: Theme.of(context).canvasColor,
                      radius: 30,
                      backgroundImage: photo != null
                          ? MemoryImage(photo)
                          : null,
                      child: photo == null
                          ? Image.asset("./assets/logos/icons/Logo_9.png")
                          : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Column(
                        children: [
                          Text(c.displayName ?? "Sem nome", style: Theme.of(context).textTheme.titleSmall,),
                          for (final p in c.phones)
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text("Telefone: ${p.number}"),
                            ),
                          for (final e in c.emails)
                            ListTile(
                              leading: Icon(Icons.email),
                              title: Text("E-mail: ${e.address}"),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      );
    },
  );
}
