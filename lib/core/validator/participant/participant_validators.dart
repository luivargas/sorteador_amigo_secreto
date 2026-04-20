import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
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

  static String? normalizePhoneFromContact(String rawPhone, IsoCode isoCode){
    String digits = rawPhone.replaceAll(RegExp(r'\D'), '');

    if(digits.isEmpty) return null;

    if(digits.startsWith('55') && digits.length > 11){
      digits = digits.substring(2);
    }

    if ( digits.startsWith('0')){
      if (digits.length == 14 || digits.length == 13) {
        digits = digits.substring(3);
      }else if ( digits.length == 12 ){
        digits = digits.substring(1);
      }
    }

    try {
      return PhoneNumber(isoCode: isoCode, nsn: digits).international;
    }catch(_){
      return rawPhone;
    }

  }

}