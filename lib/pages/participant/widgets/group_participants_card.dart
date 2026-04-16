import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/card_color.dart';
import 'package:sorteador_amigo_secreto/core/util/get_initials.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';


class GroupParticipantsCard extends StatelessWidget {
  final String groupToken;
  final String groupCode;
  final BadgeType type;
  final List<ShowParticipantModel> participantsList;

  const GroupParticipantsCard({
    super.key,
    required this.participantsList,
    required this.groupToken,
    required this.type,
    required this.groupCode,
  });

  Future<void> _goToList(BuildContext context) async {
    final result = await context.pushNamed(
      'participants_list',
    );
    if (result == true && context.mounted) {
      context.read<GroupCubit>().show(groupCode, groupToken);
    }
  }

  Widget _buildOverlappingAvatars() {
    const maxVisible = 6;
    const avatarSize = 44.0;
    const step = 30.0;

    final visibleList = participantsList.take(maxVisible).toList();
    final extra = participantsList.length - maxVisible;
    final itemCount = visibleList.length + (extra > 0 ? 1 : 0);
    final totalWidth = avatarSize + (itemCount - 1) * step;

    return SizedBox(
      height: avatarSize,
      width: totalWidth,
      child: Stack(
        children: [
          ...visibleList.asMap().entries.map((entry) {
            return Positioned(
              left: entry.key * step,
              child: _AvatarItem(
                initials: GetInitials.initials(entry.value.name),
                index: entry.key,
              ),
            );
          }),
          if (extra > 0)
            Positioned(
              left: visibleList.length * step,
              child: _ExtraAvatar(count: extra),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () => _goToList(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: SecretSantaColors.neutral50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: SecretSantaColors.neutral200.withValues(alpha: 0.8),
          ),
          boxShadow: SecretSantaShadows.medium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.participants,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      l10n.participantsSubtitle(participantsList.length),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: SecretSantaColors.accent2,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (participantsList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  l10n.noParticipantsSelected,
                  style: TextStyle(color: SecretSantaColors.neutral400, fontSize: 13),
                ),
              )
            else
              _buildOverlappingAvatars(),
          ],
        ),
      ),
    );
  }
}


class _AvatarItem extends StatelessWidget {
  final int index;
  final String initials;

  const _AvatarItem({required this.initials, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: CardColor.getColor(index),
        shape: BoxShape.circle,
        border: Border.all(color: SecretSantaColors.neutral50, width: 2),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: SecretSantaColors.neutral50,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _ExtraAvatar extends StatelessWidget {
  final int count;

  const _ExtraAvatar({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: SecretSantaColors.neutral200,
        shape: BoxShape.circle,
        border: Border.all(color: SecretSantaColors.neutral50, width: 2),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: TextStyle(
            color: SecretSantaColors.neutral600,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
