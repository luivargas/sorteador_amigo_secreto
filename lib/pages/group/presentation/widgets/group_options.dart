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
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                l10n.groupOptionsTitle,
                style: SecretSantaTextStyles.titleSmall,
              ),
            ),
            Column(
              spacing: 10,
              children: [
                Column(
                  spacing: 10,
                  children: [
                    MyGradientButton(
                      title: l10n.shareGroup,
                      icon: Icons.share,
                      onTap: () {},
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
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
