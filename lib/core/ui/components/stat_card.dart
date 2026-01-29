import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/dialog.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart' hide AlertType;
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppDialog.show(context: context, title: value, message: label);
      },
      child: Container(
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: SecretSantaColors.neutral50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColors.sorteadorOrange, width: 1),
          boxShadow: SecretSantaShadows.medium,
        ),
        child: Column(
          spacing: 12,
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: MyColors.sorteadorPurpple),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: MyColors.sorteadorOrange,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        label,
                        style: SecretSantaTextStyles.labelSmall.copyWith(
                          color: SecretSantaColors.neutral600,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
