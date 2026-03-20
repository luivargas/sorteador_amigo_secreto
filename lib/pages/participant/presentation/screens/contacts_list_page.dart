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
  late final ParticipantUsecase _usecase;
  bool _denied = false;
  bool _isCreating = false;

  List<Contact> get _filteredContacts {
    final q = _searchController.text.toLowerCase();
    if (q.isEmpty) return _contacts ?? [];
    return (_contacts ?? [])
        .where((c) => (c.displayName ?? '').toLowerCase().contains(q))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _usecase = getIt<ParticipantUsecase>();
    _searchController.addListener(() => setState(() {}));
    _loadContacts();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  bool _hasName(Contact c) => (c.displayName ?? '').trim().isNotEmpty;

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
    _sub = FlutterContacts.onContactChange.listen((_) => _load());
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
      (a, b) => (a.displayName ?? '').compareTo(b.displayName ?? ''),
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

    if (c.id == null) return;

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

    final selected = _contacts!
        .where((c) => _selectedContacts.contains(c.id))
        .toList();

    // l10n capturado antes de qualquer await para evitar uso de context em gap assíncrono
    final l10nConfirm = AppLocalizations.of(context)!;

    bool anySuccess = false;

    for (final contact in selected) {
      final phone = contact.phones.isNotEmpty
          ? contact.phones.first.number
          : null;
      final email = contact.emails.isNotEmpty
          ? contact.emails.first.address
          : null;

      final entity = CreateParticipantEntity(
        name: contact.displayName ?? '',
        email: email,
        phone: phone,
        role: 'participant',
        groupCode: widget.groupCode,
      );

      final result = await _usecase.create(entity, widget.groupId);

      String? errorMsg;
      result.when(
        success: (_) {
          anySuccess = true;
        },
        failure: (f) {
          errorMsg = l10nConfirm.errorAddingContact(
            contact.displayName ?? '',
            f.message,
          );
        },
      );

      if (errorMsg != null) {
        if (!context.mounted) break;
        // ignore: use_build_context_synchronously
        AppAlert.show(context, message: errorMsg!);
      }
    }

    setState(() => _isCreating = false);

    if (!context.mounted) return;
    // ignore: use_build_context_synchronously
    if (anySuccess) context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final selectedContacts =
        _contacts?.where((c) => _selectedContacts.contains(c.id)).toList() ??
        [];

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: MyAppBar(
        title: l10n.contactsTitle,
        subTitle: l10n.contactsSubtitle,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: l10n.searchContacts,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.selectedLabel),
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.sorteadorOrange,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: MyColors.sorteadorOrange),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            l10n.selectedCount(_selectedContacts.length),style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: MyColors.sorteadorOrange),
                  ),
                  child: selectedContacts.isEmpty
                      ? Center(
                          child: Text(
                            l10n.noParticipantsSelected,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedContacts.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 10),
                          itemBuilder: (_, i) {
                            final c = selectedContacts[i];

                            return GestureDetector(
                              onTap: () => _toggleSelection(c),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundImage:
                                            c.photo?.thumbnail != null
                                            ? MemoryImage(c.photo!.thumbnail!)
                                            : null,
                                        child: c.photo?.thumbnail == null
                                            ? const Icon(Icons.person)
                                            : null,
                                      ),
                                      Positioned(
                                        right: -2,
                                        top: -2,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: 60,
                                    child: Text(
                                      c.displayName ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
            Row(children: [Text(l10n.yourContacts)]),
            if (_denied)
              Center(child: Text(l10n.contactPermissionDenied))
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
                    itemCount: _filteredContacts.length,
                    itemBuilder: (_, i) {
                      final c = _filteredContacts[i];

                      final hasName = _hasName(c);
                      final hasPhone = _hasPhone(c);
                      final hasEmail = _hasEmail(c);
                      final isValid = _isContactValid(c);
                      final selected = _selectedContacts.contains(c.id);

                      return ListTile(
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
                                '${[if (!hasName) l10n.name, if (!hasPhone && !hasEmail) l10n.phone].join(', ')} ${l10n.fieldRequired}',
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
                        onTap: () => _toggleSelection(c),
                      );
                    },
                  ),
                ),
              ),
            MyGradientButton(
              onTap: _onConfirm,
              title: l10n.confirmButton(_selectedContacts.length),
              isLoading: _isCreating,
            ),
          ],
        ),
      ),
    );
  }
}
