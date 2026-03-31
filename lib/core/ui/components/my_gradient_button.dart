import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

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
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: MyColors.sorteadorGradient,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                        color: MyColors.neutral100,
                      ),
                    ),
                  )
                : Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 16,
                                color: MyColors.neutral100,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            if (subTitle != null) ...[subTitle!],
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
