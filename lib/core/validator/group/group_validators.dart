import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class GroupValidators {
    static String? giftValue({
    required BuildContext context,
    required String? min,
    required String? max,
  }) {
    if ((min == null || min.isEmpty) && (max == null || max.isEmpty)) {
      return null;
    }
    if ((min != null && min.isNotEmpty) && (max != null && max.isNotEmpty)) {
      final minValue = double.parse(
        min.replaceAll('.', '').replaceAll(',', '.'),
      );
      final maxValue = double.parse(
        max.replaceAll('.', '').replaceAll(',', '.'),
      );
      if (minValue > maxValue) {
        return AppLocalizations.of(context)!.validatorFixValues;
      }
    }
    return null;
  }
}