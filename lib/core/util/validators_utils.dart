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
    final ok = RegexUtils.emailRegExp.hasMatch(v.trim());
    return ok ? null : 'E-mail inválido';
  }
}
