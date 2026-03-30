import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/widgets/onboarding_card.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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
            spacing: 40,
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
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF25D366),
                                  Color(0xFF128C7E),
                                ], // WhatsApp vibe
                              ),
                            ),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.workspace_premium,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "WhatsApp Premium",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Receba seu amigo secreto direto no WhatsApp 📲",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Envie uma mensagem para o nós e receba seu resultado automaticamente.",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    l10n.onboardingTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Crie seu grupo de amigo secreto em segundos! Preencha nome, e-mail e nome do grupo. Receba link e código para compartilhar no WhatsApp.',
                  ),
                ],
              ),
              Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Como criar seu grupo!',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Column(
                    spacing: 25,
                    children: [
                      OnboardingCard(
                        icon: Icons.create,
                        title: "1. Crie o seu grupo",
                        subTitle: 'Preencha nome, e-mail e nome do grupo.',
                      ),
                      OnboardingCard(
                        icon: Icons.settings,
                        title: "2. Preencha as informações",
                        subTitle: 'Defina valor, data e regras do sorteio.',
                      ),
                      OnboardingCard(
                        icon: Icons.group_add,
                        title: "3. Adicione os participantes",
                        subTitle:
                            'Inclua seus amigos ou compartilhe o convite.',
                      ),
                      OnboardingCard(
                        icon: Icons.celebration,
                        title: "4. Faça o sorteio",
                        subTitle:
                            'Com tudo preenchido realize o sorteio e veja os resultados.',
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
