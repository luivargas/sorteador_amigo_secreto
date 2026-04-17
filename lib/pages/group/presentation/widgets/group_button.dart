import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class GroupButton extends StatelessWidget {
  const GroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SecretSantaSpacing.lg),
      child: SizedBox(
        height: 300,
        child: Column(
          spacing: SecretSantaSpacing.xl,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              spacing: SecretSantaSpacing.sm,
              children: [
                MyGradientButton(
                  title: l10n.createGroupButton,
                  icon: Icons.create,
                  subTitle: Text(
                    l10n.createGroupDesc,
                    style: const TextStyle(color: SecretSantaColors.neutral50),
                  ),
                  onTap: () async {
                    context.push("/create_group");
                  },
                ),
              ],
            ),
            Column(
              spacing: SecretSantaSpacing.sm,
              children: [
                MyGradientButton(
                  title: l10n.recoverGroup,
                  icon: Icons.group,
                  subTitle: Text(
                    l10n.recoverGroupDesc,
                    style: const TextStyle(color: SecretSantaColors.neutral50),
                  ),
                  onTap: () => context.push("/enter_group"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
