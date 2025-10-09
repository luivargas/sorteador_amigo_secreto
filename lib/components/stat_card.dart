import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

/// Card de estatística
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SnackBarAction(label: "$label - $value" , onPressed: () {}),
            showCloseIcon: true,
          ),
        );
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
            Icon(icon, size: 40, color: MyColors.sorteadorPurpple),
            ShaderMask(
              shaderCallback: (bounds) =>
                  SecretSantaColors.primaryGradient.createShader(bounds),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Text(
              label,
              style: SecretSantaTextStyles.labelSmall.copyWith(
                color: SecretSantaColors.neutral600,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
