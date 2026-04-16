import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_search_bar.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/participant/core/util/participant_validators.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/usecases/participant_usecase.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class _ContactSelection {
  final String? phone;
  final String? email;
  final IsoCode? isoCode;
  const _ContactSelection({this.phone, this.email, this.isoCode});
}

class ContactList extends StatefulWidget {
  final String groupToken;
  final String groupCode;
  const ContactList({
    super.key,
    required this.groupToken,
    required this.groupCode,
  });
  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> with WidgetsBindingObserver {
  final TextEditingController _searchController = TextEditingController();

  final Map<String, _ContactSelection> _selectedContacts = {};

  List<Contact>? _contacts;
  StreamSubscription? _sub;
  late final ParticipantUsecase _usecase;
  bool _denied = false;
  bool _isCreating = false;

  final List<Color> cardColors = [
    SecretSantaColors.accent,
    SecretSantaColors.accent2,
  ];
  Color getColor(int index) => cardColors[index % cardColors.length];

  List<Contact> get _filteredContacts {
    final q = _searchController.text.toLowerCase();
    final contacts = (_contacts ?? []).where(_hasName);
    if (q.isEmpty) return contacts.toList();
    return contacts
        .where((c) => (c.displayName ?? "").toLowerCase().contains(q))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _usecase = getIt<ParticipantUsecase>();
    _searchController.addListener(() => setState(() {}));
    _loadContacts();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _denied) {
      _loadContacts();
    }
  }

  bool _hasName(Contact c) => (c.displayName ?? '').trim().isNotEmpty;
  bool _hasPhone(Contact c) => c.phones.isNotEmpty;
  bool _hasEmail(Contact c) => c.emails.isNotEmpty;
  bool _isContactValid(Contact c) =>
      _hasName(c) && (_hasPhone(c) || _hasEmail(c));

  String _phoneLabelText(Phone p) {
    if (p.label.label == PhoneLabel.custom) return p.label.customLabel ?? '';
    final name = p.label.label.name;
    return name[0].toUpperCase() + name.substring(1);
  }

  String _emailLabelText(Email e) {
    if (e.label.label == EmailLabel.custom) return e.label.customLabel ?? '';
    final name = e.label.label.name;
    return name[0].toUpperCase() + name.substring(1);
  }

  Future<void> _loadContacts() async {
    final s = await FlutterContacts.permissions.request(
      PermissionType.readWrite,
    );
    if (s != PermissionStatus.granted && s != PermissionStatus.limited) {
      return setState(() {
        _denied = true;
      });
    }
    setState(() => _denied = false);
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

  Future<void> _toggleSelection(Contact c) async {
    if (!_isContactValid(c)) {
      SecretSantaAlertTheme(
        message: AppLocalizations.of(context)!.contactNotValid,
        type: AlertType.warning,
      );
      return;
    }

    if (c.id == null) return;

    if (_selectedContacts.containsKey(c.id)) {
      setState(() => _selectedContacts.remove(c.id));
      return;
    }

    final hasMultiplePhones = c.phones.length > 1;
    final hasMultipleEmails = c.emails.length > 1;

    if (hasMultiplePhones || hasMultipleEmails) {
      _showContactOptionsSheet(c);
    } else {
      final phone = c.phones.isNotEmpty ? c.phones.first : null;
      IsoCode? isoCode = phone != null
          ? ParticipantValidators.isoCodeFromPhone(phone)
          : null;

      if (phone != null && isoCode == null) {
        if (!mounted) return;
        isoCode = await MyPhoneFormField.showCountrySelector(context);
        if (isoCode == null || !mounted) return; // usuário cancelou
      }

      setState(() {
        _selectedContacts[c.id!] = _ContactSelection(
          phone: phone != null && isoCode != null
              ? ParticipantValidators.normalizePhoneFromContact(
                  phone.number,
                  isoCode,
                )
              : phone?.number,
          email: c.emails.isNotEmpty ? c.emails.first.address : null,
          isoCode: isoCode,
        );
      });
    }
  }

  void _showContactOptionsSheet(Contact c) {
    final l10n = AppLocalizations.of(context)!;

    String? chosenPhone = c.phones.isNotEmpty ? c.phones.first.number : null;
    String? chosenEmail = c.emails.isNotEmpty ? c.emails.first.address : null;
    IsoCode chosenIsoCode =
        (c.phones.isNotEmpty
            ? ParticipantValidators.isoCodeFromPhone(c.phones.first)
            : null) ??
        IsoCode.BR;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: c.photo?.thumbnail != null
                          ? MemoryImage(c.photo!.thumbnail!)
                          : null,
                      child: c.photo?.thumbnail == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        c.displayName ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (c.phones.length > 1) ...[
                  Text(
                    l10n.selectPhone,
                    style: TextStyle(
                      color: SecretSantaColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RadioGroup<String>(
                    groupValue: chosenPhone,
                    onChanged: (v) => setSheetState(() {
                      chosenPhone = v;
                      final match = c.phones.firstWhere(
                        (p) => p.number == v,
                        orElse: () => c.phones.first,
                      );
                      final detected = ParticipantValidators.isoCodeFromPhone(
                        match,
                      );
                      if (detected != null) chosenIsoCode = detected;
                    }),
                    child: Column(
                      children: c.phones
                          .map(
                            (p) => RadioListTile<String>(
                              contentPadding: EdgeInsets.zero,
                              value: p.number,
                              title: Text(p.number),
                              subtitle: Text(_phoneLabelText(p)),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (chosenPhone != null) ...[
                  Text(
                    l10n.countryLabel,
                    style: TextStyle(
                      color: SecretSantaColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () async {
                      final selected =
                          await MyPhoneFormField.showCountrySelector(context);
                      if (selected != null) {
                        setSheetState(() => chosenIsoCode = selected);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '+${PhoneNumber(isoCode: chosenIsoCode, nsn: '').countryCode}  ${chosenIsoCode.name}',
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (c.emails.length > 1) ...[
                  Text(
                    l10n.selectEmail,
                    style: TextStyle(
                      color: SecretSantaColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RadioGroup<String>(
                    groupValue: chosenEmail,
                    onChanged: (v) => setSheetState(() => chosenEmail = v),
                    child: Column(
                      children: c.emails
                          .map(
                            (e) => RadioListTile<String>(
                              contentPadding: EdgeInsets.zero,
                              value: e.address,
                              title: Text(e.address),
                              subtitle: Text(_emailLabelText(e)),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                MyGradientButton(
                  onTap: () {
                    setState(() {
                      _selectedContacts[c.id!] = _ContactSelection(
                        phone: chosenPhone,
                        email: chosenEmail,
                        isoCode: chosenPhone != null ? chosenIsoCode : null,
                      );
                    });
                    context.pop(ctx);
                  },
                  title: l10n.select,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _onConfirm() async {
    if (_selectedContacts.isEmpty || _contacts == null) return;

    setState(() => _isCreating = true);

    final selected = _contacts!
        .where((c) => _selectedContacts.containsKey(c.id))
        .toList();

    final l10nConfirm = AppLocalizations.of(context)!;
    bool anySuccess = false;

    for (final contact in selected) {
      final selection = _selectedContacts[contact.id];

      final entity = CreateParticipantEntity(
        name: contact.displayName!,
        email: selection?.email,
        phone: selection?.phone,
        idd: selection?.isoCode != null
            ? PhoneNumber(isoCode: selection!.isoCode!, nsn: '').countryCode
            : null,
        role: 'participant',
        groupCode: widget.groupCode,
      );

      final result = await _usecase.create(entity, widget.groupToken);

      String? errorMsg;
      result.when(
        success: (_) {
          anySuccess = true;
        },
        failure: (f) {
          errorMsg = l10nConfirm.errorAddingContact(
            contact.displayName ?? '',
            f.error.localize(context),
          );
        },
      );

      if (errorMsg != null) {
        if (!context.mounted) break;
        // ignore: use_build_context_synchronously
        SecretSantaAlertTheme(message: errorMsg!, type: AlertType.warning);
      }
    }

    setState(() => _isCreating = false);

    if (!context.mounted) return;
    if (anySuccess && context.mounted) context.pop(true);
  }

  Widget? _initials(String? name, TextStyle style) {
    final parts = name!.trim().split(' ');
    if (parts.length == 1) {
      return Center(child: Text(parts[0][0].toUpperCase(), style: style));
    }
    return Center(
      child: Text(
        '${parts.first[0]}${parts.last[0]}'.toUpperCase(),
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.contactList,
                        style: TextStyle(
                          fontSize: 12,
                          color: SecretSantaColors.accent2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        l10n.contactsTitle,
                        style: SecretSantaTextStyles.titleMedium,
                      ),
                      Text(
                        l10n.contactsSubtitle,
                        style: TextStyle(
                          fontSize: 20,
                          color: SecretSantaColors.neutral500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MySearchBar(
              controller: _searchController,
              hintText: l10n.searchParticipants,
            ),
            if (_denied)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.contacts_outlined,
                      size: 64,
                      color: SecretSantaColors.neutral500,
                    ),
                    Text(
                      l10n.contactPermissionDenied,
                      textAlign: TextAlign.center,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        if (Platform.isIOS) {
                          final uri = Uri.parse('app-settings:');
                          if (await canLaunchUrl(uri)) await launchUrl(uri);
                        } else {
                          await AppSettings.openAppSettings();
                        }
                      },
                      icon: Icon(Icons.settings_outlined),
                      label: Text(l10n.openSettings),
                    ),
                  ],
                ),
              )
            else if (_contacts == null)
              const Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredContacts.length,
                  itemBuilder: (_, i) {
                    final c = _filteredContacts[i];

                    final hasPhone = _hasPhone(c);
                    final hasEmail = _hasEmail(c);
                    final isValid = _isContactValid(c);
                    final selected = _selectedContacts.containsKey(c.id);

                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SecretSantaCard(
                        onTap: () => _toggleSelection(c),
                        color: selected
                            ? getColor(i).withValues(alpha: 0.5)
                            : SecretSantaColors.neutral100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          child: Row(
                            spacing: 15,
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: getColor(i).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: _initials(
                                  c.displayName,
                                  TextStyle(
                                    color: selected
                                        ? SecretSantaColors.neutral100
                                        : getColor(i),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      c.displayName ?? '',
                                      style: TextStyle(
                                        color: selected
                                            ? SecretSantaColors.neutral50
                                            : (isValid ? null : Colors.red),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    _buildSubtitle(
                                      l10n,
                                      hasPhone,
                                      hasEmail,
                                      isValid,
                                      c,
                                      selected,
                                    ),
                                  ],
                                ),
                              ),

                              Icon(
                                selected
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: selected
                                    ? SecretSantaColors.neutral50
                                    : getColor(i),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            MyGradientButton(
              icon: Icons.save,
              onTap: _onConfirm,
              title: l10n.confirmButton(_selectedContacts.length),
              isLoading: _isCreating,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitle(
    AppLocalizations l10n,
    bool hasPhone,
    bool hasEmail,
    bool isValid,
    Contact c,
    bool selected,
  ) {
    if (!isValid) {
      return Text(
        '${[if (!hasPhone && !hasEmail) l10n.phone].join(', ')} ${l10n.fieldRequired}',
        style: const TextStyle(color: Colors.red),
      );
    }
    return Text(
      (hasPhone) ? c.phones.first.number : c.emails.first.address,
      style: TextStyle(
        color: selected
            ? SecretSantaColors.neutral50
            : (isValid ? null : Colors.red),
        fontWeight: isValid ? FontWeight.normal : FontWeight.bold,
      ),
    );
  }
}
