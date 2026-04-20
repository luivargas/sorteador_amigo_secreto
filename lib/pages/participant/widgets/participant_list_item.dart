import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/app_list_card.dart';
import 'package:sorteador_amigo_secreto/core/util/get_initials.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/show_parti_args.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class ParticipantListItem extends StatelessWidget {
  final ParticipantModel participant;
  final Color color;
  final VoidCallback? onChanged;

  const ParticipantListItem({
    super.key,
    required this.participant,
    required this.color,
    this.onChanged,
  });

  bool get _isConfirmed => participant.viewStatus != null;

  String? _subtitle(AppLocalizations l10n) {
    if (participant.role == ParticipantRole.admin.name) return l10n.adminRole;
    if (participant.email?.isNotEmpty == true) return participant.email;
    if (participant.phone?.isNotEmpty == true) return participant.phone;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppListCard(
      title: participant.name,
      subtitle: _subtitle(l10n),
      color: color,
      initials: GetInitials.initials(participant.name),
      trailing: _StatusBadge(isConfirmed: _isConfirmed),
      onTap: () async{
       final result = await context.pushNamed(
          'view_parti',
          extra: ShowParticipantArgs(partId: participant.id),
        );
        if(result == true && context.mounted){
          onChanged?.call();
        }
      },
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
        borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
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
