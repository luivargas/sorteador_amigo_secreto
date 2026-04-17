import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class MyGradientButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Text? subTitle;
  final IconData? icon;
  final bool isLoading;
  const MyGradientButton({
    super.key,
    required this.onTap,
    required this.title,
    this.subTitle,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.all(Radius.circular(SecretSantaRadius.xl)),
      child: Container(
        decoration: BoxDecoration(
          gradient: SecretSantaColors.primaryGradient,
          borderRadius: BorderRadius.all(Radius.circular(SecretSantaRadius.xl)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(SecretSantaSpacing.md),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 50),
            child: isLoading
                ? const Center(
                    key: ValueKey('loading'),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: SecretSantaColors.neutral50,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: SecretSantaSpacing.sm,
                    children: [
                      if (icon != null)
                        Icon(icon, color: SecretSantaColors.neutral50, size: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              color: SecretSantaColors.neutral50,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          if (subTitle != null) ...[subTitle!],
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
