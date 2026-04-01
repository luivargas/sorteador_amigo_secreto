// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/create_parti_args.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/navigation/show_parti_args.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class ParticipantsListScreen extends StatefulWidget {
  final List<ShowParticipantModel> participants;
  final String groupToken;
  final String groupCode;
  final BadgeType type;

  const ParticipantsListScreen({
    super.key,
    required this.participants,
    required this.groupToken,
    required this.groupCode,
    required this.type,
  });

  @override
  State<ParticipantsListScreen> createState() => _ParticipantsListScreenState();
}

class _ParticipantsListScreenState extends State<ParticipantsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ShowParticipantModel> get _filtered {
    if (_query.isEmpty) return widget.participants;
    final q = _query.toLowerCase();
    return widget.participants.where((p) {
      return p.name.toLowerCase().contains(q) ||
          (p.email?.toLowerCase().contains(q) ?? false) ||
          (p.phone?.contains(q) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filtered = _filtered;

    return Scaffold(
      appBar: MyAppBar(
        // title: l10n.participants,
        // subTitle: l10n.participantsSubtitle(widget.participants.length),
      ),
      floatingActionButton: widget.type == BadgeType.pending
          ? FloatingActionButton(
              onPressed: () async {
                final result = await context.pushNamed(
                  'contacts',
                  extra: CreateParticipantArgs(
                    groupToken: widget.groupToken,
                    groupCode: widget.groupCode,
                  ),
                );
                if (result == true && context.mounted) {
                  context.read<GroupCubit>().show(
                    widget.groupCode,
                    widget.groupToken,
                  );
                  context.pop(true);
                }
              },
              backgroundColor: MyColors.sorteadorOrange,
              child: const Icon(Icons.person_add, color: Colors.white),
            )
          : null,
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.neutral100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: l10n.searchContacts,
                  prefixIcon: Icon(Icons.search, color: MyColors.neutral400),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          // List
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: MyColors.neutral300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.noGroupsFound,
                          style: TextStyle(color: MyColors.neutral500),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _ParticipantListItem(
                        participant: filtered[index],
                        groupToken: widget.groupToken,
                        groupCode: widget.groupCode,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ParticipantListItem extends StatelessWidget {
  final ShowParticipantModel participant;
  final String groupToken;
  final String groupCode;

  const _ParticipantListItem({
    required this.participant,
    required this.groupToken,
    required this.groupCode,
  });

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  bool get _isConfirmed => participant.viewStatus != null;
  bool get _isAdmin => participant.role == 'admin';

  @override
  Widget build(BuildContext context) {
    final contact = (participant.email?.isNotEmpty == true)
        ? participant.email!
        : (participant.phone?.isNotEmpty == true)
        ? participant.phone!
        : null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await context.pushNamed(
            'view_parti',
            extra: ShowParticipantArgs(
              partId: participant.id,
              groupToken: groupToken,
            ),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: _isAdmin
                          ? MyColors.sorteadorGradient
                          : const LinearGradient(
                              colors: [Color(0xFF4241E3), Color(0xFF652FE7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        _initials(participant.name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  if (_isConfirmed)
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: MyColors.sorteadorGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              // Name + contact
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      participant.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (_isAdmin)
                      Text(
                        'Admin',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: MyColors.sorteadorPurpple,
                          letterSpacing: 1,
                        ),
                      )
                    else if (contact != null)
                      Text(
                        contact,
                        style: TextStyle(
                          fontSize: 13,
                          color: MyColors.neutral500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status badge
              _StatusBadge(isConfirmed: _isConfirmed),
            ],
          ),
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
        color: isConfirmed ? MyColors.successBg : MyColors.neutral200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isConfirmed ? 'Confirmado' : 'Pendente',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: isConfirmed ? MyColors.successText : MyColors.neutral600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
