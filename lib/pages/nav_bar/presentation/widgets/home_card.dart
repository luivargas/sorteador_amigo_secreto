import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/cubit/home_cubit.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MyColors.sorteadorPurpple,
            MyColors.sorteadorLilac,
            MyColors.sorteadorOrange,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: SecretSantaShadows.large,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: Icon(
                Icons.card_giftcard,
                size: 80,
                color: MyColors.neutral50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crie seu grupo agora',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyColors.neutral100,
                  ),
                ),
                Text(
                  'Convide amigos, defina as regras e deixe a mágica acontecer.',
                  style: TextStyle(
                    color: MyColors.neutral100.withValues(alpha: 0.70),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              final result = await context.push(
                                "/create_group",
                              );
                              if (!context.mounted) return;
                              if (result == true) {
                                () => context.read<HomeCubit>().refreshGroups();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.neutral100,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      'Começar',
                                      style: TextStyle(
                                        color: MyColors.sorteadorPurpple,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.add_circle_rounded,
                                      color: MyColors.sorteadorPurpple,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
