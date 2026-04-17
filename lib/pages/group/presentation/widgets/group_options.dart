import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class GroupOptions extends StatelessWidget {
  const GroupOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SecretSantaSpacing.lg),
      child: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.horizontal_rule, size: 45)],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: SecretSantaSpacing.md),
              child: Text(
                l10n.groupOptionsTitle,
                style: SecretSantaTextStyles.titleSmall,
              ),
            ),
            Column(
              spacing: SecretSantaSpacing.sm,
              children: [
                Column(
                  spacing: SecretSantaSpacing.sm,
                  children: [
                    MyGradientButton(
                      title: l10n.shareGroup,
                      icon: Icons.share,
                      onTap: () {},
                    ),
                  ],
                ),
                Column(
                  spacing: SecretSantaSpacing.sm,
                  children: [
                    MyGradientButton(
                      title: l10n.archive,
                      icon: Icons.archive,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
