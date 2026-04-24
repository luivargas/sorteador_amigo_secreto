// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/app_alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/card_color.dart';
import 'package:sorteador_amigo_secreto/core/ui/form_fields/my_email_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/form_fields/my_phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/screen_padding.dart';
import 'package:sorteador_amigo_secreto/core/util/get_initials.dart';
import 'package:sorteador_amigo_secreto/core/validator/participant/participant_validators.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/usecases/participant_usecase.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/contact_review_args.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class _ReviewItem {
  final ContactReviewEntry entry;
  final PhoneController phoneCtrl;
  final TextEditingController emailCtrl;
  late final String initialPhone;

  _ReviewItem(this.entry)
    : phoneCtrl = PhoneController(
        initialValue: entry.phone.isNotEmpty
            ? _tryParse(entry.phone, entry.isoCode)
            : PhoneNumber(isoCode: entry.isoCode ?? IsoCode.BR, nsn: entry.phone),
      ),
      emailCtrl = TextEditingController(text: entry.email) {
    initialPhone = phoneCtrl.value.nsn;
  }

  bool get hasContact =>
      phoneCtrl.value.nsn.trim().isNotEmpty || emailCtrl.text.trim().isNotEmpty;

  static PhoneNumber _tryParse(String phone, IsoCode? isoCode) {
    final idd = PhoneNumber(isoCode: isoCode!, nsn: '').countryCode;
    try {
      return PhoneNumber.parse("+$idd$phone");
    } catch (_) {
      return PhoneNumber(
        isoCode: IsoCode.BR,
        nsn: phone.replaceAll(RegExp(r'\D'), ''),
      );
    }
  }

  void dispose() {
    phoneCtrl.dispose();
    emailCtrl.dispose();
  }
}

class ContactReviewScreen extends StatefulWidget {
  final ContactReviewArgs args;

  const ContactReviewScreen({super.key, required this.args});

  @override
  State<ContactReviewScreen> createState() => _ContactReviewScreenState();
}

class _ContactReviewScreenState extends State<ContactReviewScreen> {
  late final List<_ReviewItem> _items;
  late final ParticipantUsecase _usecase;
  late final GroupSession _session;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _usecase = getIt<ParticipantUsecase>();
    _session = getIt<GroupSession>();
    _items = widget.args.entries.map(_ReviewItem.new).toList();
    for (final item in _items) {
      item.phoneCtrl.addListener(() => setState(() {}));
      item.emailCtrl.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  Future<void> _onConfirm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isCreating = true);

    final List<String> successes = [];
    final List<String> failures = [];

    for (final item in _items) {
      final phone = item.phoneCtrl.value.nsn.trim();
      final email = item.emailCtrl.text.trim();

      final entity = CreateParticipantEntity(
        name: item.entry.name,
        email: email.isEmpty ? null : email,
        phone: phone.isEmpty ? null : phone,
        idd: item.entry.isoCode != null
            ? PhoneNumber(isoCode: item.entry.isoCode!, nsn: '').countryCode
            : null,
        role: 'participant',
        groupCode: _session.code,
      );

      final result = await _usecase.create(entity, _session.token);
      result.when(
        success: (_) => successes.add(item.entry.name),
        failure: (f) =>
            failures.add('${item.entry.name}: ${f.error.localize(context)}'),
      );
    }

    setState(() => _isCreating = false);
    if (!context.mounted) return;

    final body = StringBuffer();
    if (successes.isNotEmpty) {
      body.writeln('✅ Adicionados (${successes.length}):');
      for (final n in successes) {
        body.writeln('  • $n');
      }
    }
    if (failures.isNotEmpty) {
      if (body.isNotEmpty) body.writeln();
      body.writeln('❌ Falhas (${failures.length}):');
      for (final m in failures) {
        body.writeln('  • $m');
      }
    }

    await AppAlert.showAlertDialog(
      context,
      title: failures.isEmpty
          ? l10n.successTitle
          : successes.isEmpty
          ? l10n.errorTitle
          : l10n.partialTitle,
      message: body.toString().trim(),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('OK')),
      ],
    );

    if (successes.isNotEmpty && context.mounted) {
      context.pop(true);
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: MyAppBar(),
        body: SafeArea(
          child: ScreenPadding(
            child: Column(
              spacing: SecretSantaSpacing.sm,
              children: [
                Column(
                  children: [
                    Text(
                      l10n.contactReviewTitle,
                      style: SecretSantaTextStyles.titleMedium,
                    ),
                    Text(
                      l10n.contactReviewSubtitle,
                      style: SecretSantaTextStyles.body,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: SecretSantaSpacing.sm),
                    itemBuilder: (_, i) =>
                        _EntryCard(item: _items[i], index: i),
                  ),
                ),
                MyGradientButton(
                  onTap: _onConfirm,
                  isLoading: _isCreating,
                  icon: Icons.check,
                  title: l10n.confirmButton(_items.length),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  final _ReviewItem item;
  final int index;
  const _EntryCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final borderColor = SecretSantaColors.neutral200;
    final bgColor = SecretSantaColors.neutral50;
    final phone = item.initialPhone;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(SecretSantaRadius.md),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.all(SecretSantaSpacing.md),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: SecretSantaSpacing.sm,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: CardColor.getColor(index),
                  borderRadius: BorderRadius.circular(52 * 0.27),
                ),
                child: Center(child: GetInitials.initials(item.entry.name)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.entry.name, overflow: TextOverflow.ellipsis),
                  Text(phone),
                ],
              ),
            ],
          ),
          MyPhoneFormField(controller: item.phoneCtrl),
          MyEmailFormField(
            controller: item.emailCtrl,
            validator: (_) => ParticipantValidators.emailOrPhoneValidator(
              context: context,
              email: item.emailCtrl.text,
              phone: item.phoneCtrl.value.nsn,
            ),
          ),
        ],
      ),
    );
  }
}
