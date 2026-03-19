import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/usecases/participant_usecase.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class ContactListPage extends StatefulWidget {
  final int groupId;
  final String groupCode;
  const ContactListPage({
    super.key,
    required this.groupId,
    required this.groupCode,
  });
  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final TextEditingController _searchController = TextEditingController();
  final Set<Object> _selectedContacts = {};
  List<Contact>? _contacts;
  StreamSubscription? _sub;
  bool _denied = false;
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  bool _hasName(Contact c) => (c.displayName ?? "").trim().isNotEmpty;

  bool _hasPhone(Contact c) => c.phones.isNotEmpty;

  bool _hasEmail(Contact c) => c.emails.isNotEmpty;

  bool _isContactValid(Contact c) =>
      _hasName(c) && (_hasPhone(c) || _hasEmail(c));

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
        message: AppLocalizations.of(context)!.contactNotValid,
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

  Future<void> _onConfirm() async {
    if (_selectedContacts.isEmpty || _contacts == null) return;

    setState(() => _isCreating = true);

    // Filtra os contatos completos a partir dos IDs selecionados
    final selected = _contacts!.where((c) => _selectedContacts.contains(c.id)).toList();
    final usecase = getIt<ParticipantUsecase>();
    bool hasError = false;

    for (final contact in selected) {
      final phone = contact.phones.isNotEmpty ? contact.phones.first.number : null;
      final email = contact.emails.isNotEmpty ? contact.emails.first.address : null;

      final entity = CreateParticipantEntity(
        name: contact.displayName ?? '',
        email: email,
        phone: phone,
        role: 'participant',
        groupCode: widget.groupCode,
      );

      final result = await usecase.create(entity, widget.groupId);
      result.when(
        success: (_) {},
        failure: (f) {
          hasError = true;
          if (context.mounted) {
            AppAlert.show(
              context,
              message: AppLocalizations.of(context)!.errorAddingContact(contact.displayName ?? '', f.message),
            );
          }
        },
      );
    }

    setState(() => _isCreating = false);

    if (!hasError && context.mounted) {
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).canvasColor,
    appBar: MyAppBar(title: AppLocalizations.of(context)!.contactsTitle, subTitle: AppLocalizations.of(context)!.contactsSubtitle),
    body: Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        spacing: 10,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: AppLocalizations.of(context)!.searchContacts,
            ),
          ),
          Row(),
          Row(
            children: [
              Text(AppLocalizations.of(context)!.yourContacts),
            ],
          ),
          if (_denied)
            Center(child: Text(AppLocalizations.of(context)!.contactPermissionDenied))
          else if (_contacts == null)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: MyColors.sorteadorOrange),
                ),
                child: ListView.builder(
                  itemCount: _contacts!.length,
                  itemBuilder: (_, i) {
                    final c = _contacts![i];

                    final hasName = _hasName(c);
                    final hasPhone = _hasPhone(c);
                    final hasEmail = _hasEmail(c);
                    final isValid = _isContactValid(c);
                    final selected = _selectedContacts.contains(c.id);

                    return Column(
                      children: [
                        ListTile(
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
                              color: selected
                                  ? MyColors.sorteadorGrey
                                  : (isValid ? null : Colors.red),
                              fontWeight: isValid
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                          subtitle: !isValid
                              ? Text(
                                  "${[if (!hasName) "Nome", if (!hasPhone && !hasEmail) "Telefone"].join(", ")} Obrigatório",
                                  style: const TextStyle(color: Colors.red),
                                )
                              : null,
                          trailing: GestureDetector(
                            onTap: () => _toggleSelection(c),
                            child: Icon(
                              selected
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: MyColors.sorteadorOrange,
                            ),
                          ),
                          onTap: () => context.push('/contact_page/${c.id}'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          MyGradientButton(
            onTap: _onConfirm,
            title: AppLocalizations.of(context)!.confirmButton(_selectedContacts.length),
            isLoading: _isCreating,
          ),
        ],
      ),
    ),
    // => context.push('/edit_contact_page'),
  );
}
