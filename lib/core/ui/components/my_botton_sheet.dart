import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/app_list_card.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/group_model.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class MyBottonSheet {
  static void show({
    required String title,
    required String subTitle,
    required BuildContext context,
    GroupModel? group,
    required List<AppListCard> items,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: SecretSantaColors.background,
      context: context,
      builder: (_) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(SecretSantaSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: SecretSantaSpacing.md,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: SecretSantaColors.neutral600.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
                    ),
                    child: SizedBox(height: 7, width: 80),
                  ),
                ],
              ),
              Column(
                spacing: SecretSantaSpacing.xs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: SecretSantaTextStyles.titleMedium),
                  Text(
                    subTitle.toUpperCase(),
                    style: SecretSantaTheme.theme.textTheme.bodySmall,
                  ),
                ],
              ),
              ...items,
            ],
          ),
        ),
      ),
    );
  }
}
// 