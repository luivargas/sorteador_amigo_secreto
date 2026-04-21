import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:flutter_contacts/models/properties/phone.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/util/regex_utils.dart';

class ParticipantValidators {
  static String? isValidEmail({
    required BuildContext context,
    required String? v,
  }) {
    final ok = RegexUtils.emailRegExp.hasMatch(v ?? "");
    return ok ? null : AppLocalizations.of(context)!.validatorInvalidEmail;
  }

  static String? nameValidator({
    required BuildContext context,
    required String v,
  }) {
    if (v.isEmpty) {
      return AppLocalizations.of(context)!.validatorRequired;
    }
    return null;
  }

  static String? emailOrPhoneValidator({
    required BuildContext context, 
    required String? email,
    
    required String phone
  }) {
    final emailEmpty = email == null || email.trim().isEmpty;
    final phoneEmpty = phone.trim().isEmpty;

    if ( emailEmpty && phoneEmpty ){
      return AppLocalizations.of(context)!.validatorEmailOrPhone;
    }

    if ( !emailEmpty) { 
      return isValidEmail(context: context, v: email);
    }
    return null;
  }

    static String? isRequiredEmailValidator({
    required BuildContext context,
    required String? v,
  }) {
    if (v == null || v.trim().isEmpty) {
      return AppLocalizations.of(context)!.validatorEnterEmail;
    }
    return isValidEmail(context: context, v: v);
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