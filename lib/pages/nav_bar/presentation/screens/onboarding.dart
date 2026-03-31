import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/widgets/onboarding_card.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<Color> cardColors = [
    MyColors.sorteadorOrange,
    MyColors.sorteadorPurpple,
  ];

  Color getColor(int index) {
    return cardColors[index % cardColors.length];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Theme.of(context).canvasColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: MyColors.primaryGradient,
                            ),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Crie seu Amigo Secreto em Segundos",
                                  style: TextStyle(
                                    color: MyColors.neutral100,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Organize seus grupos de Amigo Secreto, edite as informações dos grupos e adicione participantes de forma simples e rápida",
                                  style: TextStyle(
                                    color: MyColors.neutral100.withValues(
                                      alpha: 0.70,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: FloatingActionButton(
                                          onPressed: () {},
                                          child: Text("Criar meu grupo agora"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Como funciona?',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Column(
                    spacing: 25,
                    children: [
                      StepCard(
                        step: "01",
                        icon: Icons.create,
                        title: "Crie o seu grupo",
                        description: 'Preencha nome, e-mail e nome do grupo.',
                        color: getColor(0),
                      ),
                      StepCard(
                        step: "02",
                        icon: Icons.settings,
                        title: "Preencha as informações",
                        description: 'Defina valor, data e regras do sorteio.',
                        color: getColor(1),
                      ),
                      StepCard(
                        step: "03",
                        icon: Icons.group_add,
                        title: "Adicione os participantes",
                        description:
                            'Inclua seus amigos ou compartilhe o convite.',
                        color: getColor(2),
                      ),
                      StepCard(
                        step: "04",
                        icon: Icons.celebration,
                        title: "Faça o sorteio",
                        description:
                            'Com tudo preenchido realize o sorteio e veja os resultados.',
                        color: getColor(3),
                      ),
                      _buildInfoCard(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoCard() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: BorderRadius.circular(16),
    ),
    clipBehavior: Clip.hardEdge,
    child: Stack(
      children: [
        Positioned(
          right: -32,
          bottom: -32,
          child: Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  const Text(
                    'Totalmente Gratuito',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: MyColors.neutral100,
                    ),
                  ),
                  Text(
                    'Organize quantos grupos quiser sem pagar nada. A diversão é por nossa conta!',
                    style: TextStyle(
                      fontSize: 14,
                      color: MyColors.neutral100.withValues(alpha: 0.75),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: MyColors.sorteadorOrange,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.volunteer_activism,
                color: MyColors.neutral100,
                size: 36,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
