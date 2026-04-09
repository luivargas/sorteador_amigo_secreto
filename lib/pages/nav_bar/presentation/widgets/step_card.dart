import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class StepCard extends StatelessWidget {
  final String step;
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isLast;
  const StepCard({
    super.key,
    required this.step,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        spacing: 20,
        children: [
          Column(
            spacing: 10,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: SecretSantaColors.neutral500.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.stepLabel(step),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.all(16),
    //   decoration: BoxDecoration(
    //     color: SecretSantaColors.neutral50,
    //     borderRadius: BorderRadius.circular(16),
    //     border: Border.all(
    //       color: SecretSantaColors.neutral200.withValues(alpha: 0.8),
    //     ),
    //     boxShadow: SecretSantaShadows.small,
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     spacing: 12,
    //     children: [
    //       Container(
    //         width: 52,
    //         height: 52,
    //         decoration: BoxDecoration(
    //           color: color.withValues(alpha: 0.1),
    //           borderRadius: BorderRadius.circular(14),
    //         ),
    //         child: Icon(icon, color: color, size: 28),
    //       ),
    //       Row(
    //         children: [
    //           Flexible(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               spacing: 4,
    //               children: [
    //                 Text(
    //                   AppLocalizations.of(context)!.stepLabel(step),
    //                   style: TextStyle(
    //                     fontSize: 10,
    //                     fontWeight: FontWeight.w800,
    //                     letterSpacing: 2,
    //                     color: color.withValues(alpha: 0.7),
    //                   ),
    //                 ),
    //                 Text(
    //                   title,
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.w700,
    //                     fontSize: 15,
    //                     color: SecretSantaColors.neutral900,
    //                   ),
    //                 ),
    //                 Text(
    //                   description,
    //                   style: const TextStyle(
    //                     fontSize: 12,
    //                     color: SecretSantaColors.neutral600,
    //                     height: 1.5,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
