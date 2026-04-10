import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/properties/phone.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/util/regex_utils.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class ValidatorUtils {

  static String? isValidEmail({required BuildContext context, required String? v}) {
    final ok = RegexUtils.emailRegExp.hasMatch(v ?? "");
    return ok ? null : AppLocalizations.of(context)!.validatorInvalidEmail;
  }

  static String? nameValidator({required BuildContext context, required String v}) {
    if (v.isEmpty) {
      return AppLocalizations.of(context)!.validatorRequired;
    }
    return null;
  }

    static String? tokenValidator({required BuildContext context, required String v}) {
    if (v.isEmpty) {
      return AppLocalizations.of(context)!.validatorRequired;
    }
    return null;
  }

  static String? emailValidator({required BuildContext context, required String? v}) {
    if (v == null || v.trim().isEmpty) {
      return AppLocalizations.of(context)!.validatorEnterEmail;
    }
    return isValidEmail(context: context, v: v);
  }

  static String? giftValue({required BuildContext context, required String? min, required String? max}) {
    if (min == '' && max == '') {
      return null;
    }
    if (min != '' && max != '') {
      final minGiftValue = double.parse(
        min!.replaceFirst("R\$", "").trim().replaceAll(".", "").replaceAll(",", "."),
      );
      final maxGiftValue = double.parse(
        max!.replaceFirst("R\$", "").trim().replaceAll(".", "").replaceAll(",", "."),
      );
      if (minGiftValue > maxGiftValue) {
        return AppLocalizations.of(context)!.validatorFixValues;
      }
    }
    return null;
  }

    static IsoCode? isoCodeFromPhone(Phone phone) {
    final raw = phone.number.replaceAll(RegExp(r'[\s\-\(\)\.]+'), '');
    if (!raw.startsWith('+')) return null;

    try {
      return PhoneNumber.parse(raw).isoCode;
    } catch (_) {
      return null;
    }
  }
}
