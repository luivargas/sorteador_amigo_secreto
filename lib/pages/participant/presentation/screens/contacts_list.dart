// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/app_alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/card_color.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/form_fields/my_phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_search_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/screen_padding.dart';
import 'package:sorteador_amigo_secreto/core/util/get_initials.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/core/validator/participant/participant_validators.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/usecases/participant_usecase.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/contact_review_args.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class _ContactSelection {
  final String? phone;
  final String? email;
  final IsoCode? isoCode;
  const _ContactSelection({this.phone, this.email, this.isoCode});
}

class ContactList extends StatefulWidget {
  const ContactList({super.key});
  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> with WidgetsBindingObserver {
  final TextEditingController _searchController = TextEditingController();

  final Map<String, _ContactSelection> _selectedContacts = {};
  final group = getIt<GroupSession>();

  List<Contact>? _contacts;
  StreamSubscription? _sub;
  late final ParticipantUsecase _usecase;
  bool _denied = false;
  bool _isCreating = false;

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
      AppAlert.showBanner(
        context,
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
        if (isoCode == null || !mounted) return;
      }

      setState(() {
        _selectedContacts[c.id!] = _ContactSelection(
          phone: phone?.number,
          email: c.emails.isNotEmpty ? c.emails.first.address : null,
          isoCode: isoCode,
        );
      });
    }
  }

  void _showContactOptionsSheet(Contact c) {
    final i18n = AppLocalizations.of(context)!;

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
            padding: const EdgeInsets.fromLTRB(
              SecretSantaSpacing.lg,
              SecretSantaSpacing.md,
              SecretSantaSpacing.lg,
              SecretSantaSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(
                      bottom: SecretSantaSpacing.md,
                    ),
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
                    i18n.selectPhone,
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
                    i18n.countryLabel,
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
                    i18n.selectEmail,
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
                  title: i18n.select,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSend() {
    if (_selectedContacts.isEmpty || _contacts == null) return;

    final entries = _contacts!
        .where((c) => _selectedContacts.containsKey(c.id))
        .map((c) {
          final sel = _selectedContacts[c.id]!;
          return ContactReviewEntry(
            name: c.displayName ?? '',
            phone: sel.phone ?? '',
            email: sel.email ?? '',
            isoCode: sel.isoCode,
          );
        })
        .toList();

    context.pushNamed(
      'contact_review',
      extra: ContactReviewArgs(entries: entries),
    );
  }

  Future<void> _onConfirm() async {
    if (_selectedContacts.isEmpty || _contacts == null) return;

    setState(() => _isCreating = true);

    final selected = _contacts!
        .where((c) => _selectedContacts.containsKey(c.id))
        .toList();

    final i18n = AppLocalizations.of(context)!;
    final List<String> successes = [];
    final List<String> failures = [];

    for (final contact in selected) {
      final selection = _selectedContacts[contact.id];
      final name = contact.displayName ?? '';

      final entity = CreateParticipantEntity(
        name: name,
        email: selection?.email,
        phone: selection?.phone,
        idd: selection?.isoCode != null
            ? PhoneNumber(isoCode: selection!.isoCode!, nsn: '').countryCode
            : null,
        role: 'participant',
        groupCode: group.code,
      );

      final result = await _usecase.create(entity, group.token);

      result.when(
        success: (_) => successes.add(name),
        failure: (f) => failures.add('$name: ${f.error.localize(context)}'),
      );
    }

    setState(() => _isCreating = false);

    if (!context.mounted) return;

    final StringBuffer body = StringBuffer();

    if (successes.isNotEmpty) {
      body.writeln(
        '✅ ${i18n.participantAddedSuccess('')} (${successes.length}):',
      );
      for (final name in successes) {
        body.writeln('  • $name');
      }
    }

    if (failures.isNotEmpty) {
      if (body.isNotEmpty) body.writeln();
      body.writeln(
        '❌ ${i18n.errorAddingContact('', '')} (${failures.length}):',
      );
      for (final msg in failures) {
        body.writeln('  • $msg');
      }
    }

    await AppAlert.showAlertDialog(
      context,
      title: failures.isEmpty
          ? i18n.successTitle
          : successes.isEmpty
          ? i18n.errorTitle
          : i18n.partialTitle,
      message: body.toString().trim(),
      actions: [
        TextButton(
          onPressed: () => context.pop(successes.isNotEmpty),
          child: const Text('OK'),
        ),
      ],
    );
    if (successes.isNotEmpty && context.mounted) {
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: ScreenPadding(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  children: [
                    Text(
                      i18n.contactsTitle,
                      style: SecretSantaTextStyles.titleMedium,
                    ),
                    Text(
                      i18n.contactsSubtitle,
                      style: TextStyle(
                        fontSize: 20,
                        color: SecretSantaColors.neutral500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              MySearchBar(
                controller: _searchController,
                hintText: i18n.searchParticipants,
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
                        i18n.contactPermissionDenied,
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
                        label: Text(i18n.openSettings),
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
                              ? CardColor.getColor(i).withValues(alpha: 0.5)
                              : SecretSantaColors.neutral50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            child: Row(
                              spacing: SecretSantaSpacing.md,
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: CardColor.getColor(
                                      i,
                                    ).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: GetInitials.initials(
                                    c.displayName!,
                                    style: TextStyle(
                                      color: selected
                                          ? SecretSantaColors.neutral100
                                          : CardColor.getColor(i),
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
                                        i18n,
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
                                      : CardColor.getColor(i),
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
                onTap: _onSend,
                title: i18n.confirmButton(_selectedContacts.length),
                isLoading: _isCreating,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle(
    AppLocalizations i18n,
    bool hasPhone,
    bool hasEmail,
    bool isValid,
    Contact c,
    bool selected,
  ) {
    if (!isValid) {
      return Text(
        '${[if (!hasPhone && !hasEmail) i18n.phone].join(', ')} ${i18n.fieldRequired}',
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
