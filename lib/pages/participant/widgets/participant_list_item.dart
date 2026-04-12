import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/app_list_card.dart';
import 'package:sorteador_amigo_secreto/core/util/get_initials.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/show_parti_args.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class ParticipantListItem extends StatelessWidget {
  final ShowParticipantModel participant;
  final String groupToken;
  final String groupCode;
  final Color color;

  const ParticipantListItem({
    super.key,
    required this.participant,
    required this.groupToken,
    required this.groupCode,
    required this.color,
  });

  bool get _isConfirmed => participant.viewStatus != null;

  String? get _subtitle {
    if (participant.role == 'admin') return 'Admin';
    if (participant.email?.isNotEmpty == true) return participant.email;
    if (participant.phone?.isNotEmpty == true) return participant.phone;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppListCard(
      title: participant.name,
      subtitle: _subtitle,
      color: color,
      initials: GetInitials.initials(participant.name),
      trailing: _StatusBadge(isConfirmed: _isConfirmed),
      onTap: () => context.pushNamed(
        'view_parti',
        extra: ShowParticipantArgs(
          partId: participant.id,
          groupToken: groupToken,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isConfirmed;
  const _StatusBadge({required this.isConfirmed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isConfirmed
            ? SecretSantaColors.successBg
            : SecretSantaColors.neutral200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isConfirmed
            ? AppLocalizations.of(context)!.statusConfirmed
            : AppLocalizations.of(context)!.statusPending,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: isConfirmed
              ? SecretSantaColors.successText
              : SecretSantaColors.neutral600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
