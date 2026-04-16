import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/app_list_card.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class MyBottonSheet {
  static void show({
    required String title,
    required String subTitle,
    required BuildContext context,
    ShowGroupModel? group,
    required List<AppListCard> items,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: SecretSantaColors.background,
      context: context,
      builder: (_) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 15,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: SecretSantaColors.neutral600.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(height: 7, width: 80),
              ),
              Row(
                children: [
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: SecretSantaTextStyles.titleMedium,
                      ),
                      Text(
                        subTitle.toUpperCase(),
                        style: SecretSantaTheme.theme.textTheme.bodySmall,
                      ),
                    ],
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