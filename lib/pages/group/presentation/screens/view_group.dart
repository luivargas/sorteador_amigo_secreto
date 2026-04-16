import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/network/url/base_url/web.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/app_list_card.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/view_group/view_group_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ViewGroup extends StatefulWidget {
  final String code;
  final String token;
  final String? name;
  const ViewGroup({
    super.key,
    required this.code,
    required this.token,
    this.name,
  });

  @override
  State<ViewGroup> createState() => _ViewGroupBody();
}

class _ViewGroupBody extends State<ViewGroup> {
  final RefreshController _refreshController = RefreshController();
  late final ConfettiController _confettiController;
  bool _showRaffleSuccess = false;
  bool _didChange = false;
  ShowGroupModel? group;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  Future<void> _onShare(ShowGroupModel? g) async {
    final title = AppLocalizations.of(context)!.shareLinkTitle;
    await SharePlus.instance.share(
      ShareParams(
        uri: Uri.parse("$stgSiteBaseUrl/grupo/${g?.code}/entrar"),
        title: title,
        subject: title,
      ),
    );
  }

  Future<void> _onEdit() async {
    final result = await context.pushNamed(
      'edit_group',
      extra: ShowGroupArgs(code: widget.code, token: widget.token),
    );
    if (context.mounted && result == true) {
      _didChange = true;
      _onRefresh();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<GroupCubit>().show(widget.code, widget.token);
    _refreshController.refreshCompleted();
  }

  Future<void> _onSubmit(String code) async {
    await context.read<GroupCubit>().raffle(code, widget.token);
  }

  String _formatDate(String? drawDate) {
    if (drawDate == null) return '--';
    try {
      final datePart = drawDate.split(' ').first;
      final parsed = DateFormat('dd/MM/yyyy').parse(datePart);
      return DateFormat.yMMMd('pt_BR').format(parsed);
    } catch (_) {
      return drawDate.split(' ').first;
    }
  }

  Future<void> _onDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    if (context.mounted) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l10n.delete),
          content: Text(l10n.confirmDeleteGroup(widget.name ?? '')),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: Text(
                l10n.cancel,
                style: const TextStyle(color: SecretSantaColors.accent2),
              ),
            ),
            TextButton(
              onPressed: () => context.pop(true),
              child: Text(
                l10n.delete,
                style: const TextStyle(color: SecretSantaColors.accent),
              ),
            ),
          ],
        ),
      );

      if (confirmed == true && context.mounted) {
        context.read<GroupCubit>().delete(widget.code, widget.token);
      }
    }
  }

  void _showOptions(BuildContext context, ShowGroupModel? group) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      backgroundColor: SecretSantaColors.background,
      context: context,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 15,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: [
                    Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.groupActions,
                          style: SecretSantaTextStyles.titleMedium,
                        ),
                        Text(
                          l10n.groupOptionsTitle.toUpperCase(),
                          style: SecretSantaTheme.theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!getIt<GroupSession>().isRaffled) ...[
                AppListCard(
                  title: l10n.shareGroup,
                  subtitle: l10n.shareGroupSubtitle,
                  color: SecretSantaColors.accent,
                  icon: Icons.share,
                  initials: '',
                  trailing: Icon(
                    Icons.chevron_right,
                    color: SecretSantaColors.accent,
                  ),
                  onTap: () {
                    context.pop();
                    _onShare(group);
                  },
                ),
              ],
              AppListCard(
                title: l10n.edit,
                subtitle: l10n.editGroupSubtitle2,
                color: SecretSantaColors.accent2,
                icon: Icons.edit,
                initials: '',
                trailing: Icon(
                  Icons.chevron_right,
                  color: SecretSantaColors.accent2,
                ),
                onTap: () {
                  context.pop();
                  _onEdit();
                },
              ),
              AppListCard(
                title: l10n.deleteGroup,
                subtitle: l10n.deleteGroupSubtitle,
                color: SecretSantaColors.error,
                icon: Icons.delete_outline,
                initials: '',
                trailing: Icon(
                  Icons.chevron_right,
                  color: SecretSantaColors.error,
                ),
                onTap: () {
                  context.pop();
                  _onDelete(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if(!didPop) context.pop(_didChange);
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: MyAppBar(
              actions: [
                IconButton(
                  onPressed: () => _showOptions(context, group),
                  icon: const Icon(Icons.more_vert, size: 24),
                  color: SecretSantaColors.accent,
                ),
              ],
            ),
            body: BlocConsumer<GroupCubit, GroupState>(
              listenWhen: (previous, current) =>
                  (!previous.raffled && current.raffled) ||
                  (previous.error == null && current.error != null) || (!previous.deleted && current.deleted) ,
              listener: (context, state) {
                if (state.raffled) {
                  setState(() => _showRaffleSuccess = true);
                  _confettiController.play();
                  _onRefresh();
                }
                if (state.error != null) {
                  SecretSantaAlert.show(
                    context: context,
                    message: state.error!.localize(context),
                    type: AlertType.warning,
                  );
                }
                if(state.deleted) {
                  context.pop(true);
                }
              },
              builder: (context, state) {
                if (state.isLoading && state.group == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: SecretSantaColors.accent,
                    ),
                  );
                }
                if (state.group != null) {
                  group = state.group!;
                }
                if (group == null) return const SizedBox.shrink();
      
                final g = group!;
                final type = g.raffledAt == null
                    ? BadgeType.pending
                    : BadgeType.raffled;
      
                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                    children: [
                      _GroupHeroHeader(name: g.name, type: type),
                      const SizedBox(height: 16),
                      ViewGroupCard(
                        type: type,
                        eventLocation: g.location ?? l10n.notDefined,
                        minGiftValue: g.minGiftValue ?? "00,00",
                        maxGiftValue: g.maxGiftValue ?? "00,00",
                        eventDate: _formatDate(g.drawDate),
                        eventTime: g.drawDate?.split(' ').last ?? "--:--",
                        groupDescription: g.description ?? l10n.noDescription,
                        participants: g.participants.length,
                        participantsList: g.participants,
                        groupToken: g.token,
                        groupCode: g.code,
                      ),
                      if (g.raffledAt == null) ...[
                        const SizedBox(height: 24),
                        if (g.participants.length >= 2)
                          MyGradientButton(
                            onTap: () => _onSubmit(g.code),
                            title: l10n.drawButton,
                            icon: Icons.draw,
                          )
                        else
                          _NeedMoreParticipantsBanner(
                            message: AppLocalizations.of(
                              context,
                            )!.needMoreParticipants,
                          ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
      
          if (_showRaffleSuccess)
            GestureDetector(
              onTap: () => setState(() => _showRaffleSuccess = false),
              child: Container(color: Colors.black.withValues(alpha: 0.6)),
            ).animate().fadeIn(duration: 300.ms),
      
          if (_showRaffleSuccess)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child:
                    Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: SecretSantaColors.neutral50,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: SecretSantaShadows.large,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 16,
                            children: [
                              Icon(
                                Icons.celebration,
                                size: 72,
                                color: SecretSantaColors.accent2,
                              ).animate().scale(
                                begin: const Offset(0.5, 0.5),
                                curve: Curves.elasticOut,
                                duration: 700.ms,
                              ),
                              Text(
                                l10n.raffleCompleted,
                                style: SecretSantaTextStyles.titleSmall,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                l10n.raffleCompletedMessage,
                                style: SecretSantaTextStyles.bodySmall.copyWith(
                                  color: SecretSantaColors.neutral500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          curve: Curves.easeOutBack,
                          duration: 400.ms,
                        )
                        .fadeIn(duration: 300.ms),
              ),
            ),
      
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 30,
              colors: const [
                SecretSantaColors.accent,
                SecretSantaColors.accent2,
                SecretSantaColors.accent3,
                SecretSantaColors.success,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupHeroHeader extends StatelessWidget {
  final String name;
  final BadgeType type;

  const _GroupHeroHeader({required this.name, required this.type});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 24, 100, 24),
            decoration: BoxDecoration(
              gradient: SecretSantaColors.primaryGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: SecretSantaShadows.button,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                SecretSantaBadge(type: type),
                Text(
                  name,
                  style: SecretSantaTextStyles.titleMedium.copyWith(
                    color: SecretSantaColors.neutral50,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Positioned(
            right: -20,
            child: Icon(
              Icons.group,
              size: 130,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}

class _NeedMoreParticipantsBanner extends StatelessWidget {
  final String message;
  const _NeedMoreParticipantsBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: SecretSantaColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: SecretSantaColors.accent.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        spacing: 12,
        children: [
          Icon(Icons.info_outline, color: SecretSantaColors.accent),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: SecretSantaColors.accent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
