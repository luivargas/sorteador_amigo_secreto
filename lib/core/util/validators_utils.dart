import 'package:sorteador_amigo_secreto/core/util/regex_utils.dart';

class ValidatorUtils {
  static String? isValidEmail({required String? v}) {
    final ok = RegexUtils.emailRegExp.hasMatch(v ?? "");
    return ok ? null : 'E-mail inválido';
  }

  static String? nameValidator({required String v}) {
    if (v.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  static String? emailValidator({required String? v}) {
    if (v == null || v.trim().isEmpty) {
      return 'Informe seu e-mail';
    }
    return isValidEmail(v: v);
  }

  static String? giftValue({required String? min, required String? max}) {
    if (min == '' && max == '') {
      return null;
    }
    if (min != '' && max != '') {
      final minGiftValue = double.parse(
        min!.replaceAll(",", ".").replaceFirst("R\$", "").trim(),
      );
      final maxGiftValue = double.parse(
        max!.replaceAll(",", ".").replaceFirst("R\$", "").trim(),
      );
      if (minGiftValue > maxGiftValue) {
        return 'Corrija os valores';
      }
    }
    return null;
  }
}
