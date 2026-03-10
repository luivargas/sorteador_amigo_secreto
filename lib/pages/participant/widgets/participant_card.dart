import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class ParticipantCard extends StatelessWidget {
  final Widget child;
  final Widget? image;
  final MyGradientButton? button;

  const ParticipantCard({
    super.key,
    required this.child,
    this.image,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: SecretSantaColors.neutral50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColors.sorteadorOrange, width: 1),
          boxShadow: SecretSantaShadows.medium,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: Theme.of(context).canvasColor,
                  border: Border.all(color: MyColors.sorteadorOrange, width: 1),
                ),
                child: image,
              ),
              child,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: button,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
