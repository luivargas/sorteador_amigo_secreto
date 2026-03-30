import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class OnboardingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  const OnboardingCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: MyColors.sorteadorGradient,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, size: 25, color: Colors.white),
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold),), Text(subTitle)],
          ),
        ),
      ],
    );
  }
}
