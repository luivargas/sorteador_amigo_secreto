import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/network/url/base_url/web.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/app_alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/app_list_card.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_botton_sheet.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/screen_padding.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/view_group/view_group_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:share_plus/share_plus.dart';
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
  GroupModel? group;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  Future<void> _onShare(GroupModel? g) async {
    final title = AppLocalizations.of(context)!.shareLinkTitle;
    await SharePlus.instance.share(
      ShareParams(
        uri: Uri.parse("$prodSiteBaseUrl/grupo/${g?.code}/entrar"),
        title: title,
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
        if (!didPop) context.pop(_didChange);
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: MyAppBar(
              actions: [
                IconButton(
                  onPressed: () => MyBottonSheet.show(
                    title: l10n.groupOptionsTitle,
                    subTitle: l10n.groupActions,
                    context: context,
                    group: group,
                    items: [
                      if (!getIt<GroupSession>().isRaffled) ...[
                        AppListCard(
                          title: l10n.shareGroup,
                          subtitle: l10n.shareGroupSubtitle,
                          color: SecretSantaColors.accent,
                          icon: Icons.share,
                          name: '',
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
                        name: '',
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
                        name: '',
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
                  icon: const Icon(Icons.more_vert, size: 24),
                  color: SecretSantaColors.accent,
                ),
              ],
            ),
            body: ScreenPadding(
              child: BlocConsumer<GroupCubit, GroupState>(
                listenWhen: (previous, current) =>
                    (!previous.raffled && current.raffled) ||
                    (previous.error == null && current.error != null) ||
                    (!previous.deleted && current.deleted) ||
                    (!previous.logout && current.logout),
                listener: (context, state) async {
                  if (state.logout) {
                    final l10n = AppLocalizations.of(context)!;
                    await AppAlert.showAlertDialog(
                      context,
                      title: l10n.errorTitle,
                      message: l10n.errorUnauthorized,
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                            context.goNamed('request_token');
                          },
                          child: Text(l10n.ok),
                        ),
                      ],
                    );
                    return;
                  }
                  if (state.raffled) {
                    setState(() => _showRaffleSuccess = true);
                    _confettiController.play();
                    _onRefresh();
                  }
                  if (state.error != null) {
                    AppAlert.showBanner(
                      context,
                      message: state.error!.localize(context),
                      type: AlertType.warning,
                    );
                  }
                  if (state.deleted) {
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
                      children: [
                        _GroupHeroHeader(name: g.name, type: type),
                        const SizedBox(height: 16),
                        _WhatsAppCard(
                          code: g.code,
                          whatsAppPremium: g.whatsappEnabled,
                          onRefresh: _onRefresh,
                        ),
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
          ),

          if (_showRaffleSuccess)
            GestureDetector(
              onTap: () => setState(() => _showRaffleSuccess = false),
              child: Container(color: Colors.black.withValues(alpha: 0.6)),
            ).animate().fadeIn(duration: 300.ms),

          if (_showRaffleSuccess)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SecretSantaSpacing.xl,
                ),
                child:
                    Container(
                          padding: const EdgeInsets.all(SecretSantaSpacing.xl),
                          decoration: BoxDecoration(
                            color: SecretSantaColors.neutral50,
                            borderRadius: BorderRadius.circular(
                              SecretSantaRadius.xxl,
                            ),
                            boxShadow: SecretSantaShadows.large,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: SecretSantaSpacing.md,
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
      borderRadius: BorderRadius.circular(SecretSantaRadius.xxl),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              SecretSantaSpacing.lg,
              SecretSantaSpacing.lg,
              100,
              SecretSantaSpacing.lg,
            ),
            decoration: BoxDecoration(
              gradient: SecretSantaColors.primaryGradient,
              borderRadius: BorderRadius.circular(SecretSantaRadius.xxl),
              boxShadow: SecretSantaShadows.button,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: SecretSantaSpacing.md,
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
      padding: const EdgeInsets.symmetric(
        horizontal: SecretSantaSpacing.md,
        vertical: SecretSantaSpacing.md,
      ),
      decoration: BoxDecoration(
        color: SecretSantaColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(SecretSantaRadius.lg),
        border: Border.all(
          color: SecretSantaColors.accent.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        spacing: SecretSantaSpacing.sm,
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

class _WhatsAppCard extends StatelessWidget {
  final String code;
  final bool whatsAppPremium;
  final Function() onRefresh;
  const _WhatsAppCard({
    required this.code,
    required this.whatsAppPremium,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> onShare() async {
      final title = AppLocalizations.of(context)!.shareLinkTitle;
      await SharePlus.instance.share(
        ShareParams(
          uri: Uri.parse("https://wa.me/553131813133?text=quem%20tirei"),
          title: title,
        ),
      );
    }

    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      splashColor: SecretSantaColors.whatsApp.withValues(alpha: 0.2),
      highlightColor: SecretSantaColors.whatsApp.withValues(alpha: 0.1),
      onTap: () async {
        if (whatsAppPremium) {
          if (context.mounted) {
            AppAlert.showAlertDialog(
              context,
              title: l10n.whatsappActivatedTitle,
              message: l10n.whatsappActivatedAlertMessage,
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(l10n.cancel),
                ),
                TextButton(
                  onPressed: () {
                    onShare();
                  },
                  child: Text(l10n.sendButton),
                ),
              ],
            );
          }
        }
        if (!whatsAppPremium) {
          final result = await context.pushNamed('whatsapp_premium');
          if (result == true) {
            if (context.mounted) {
              onRefresh();
            }
          }
        }
      },
      borderRadius: BorderRadius.circular(SecretSantaRadius.lg),
      child: Ink(
        padding: const EdgeInsets.all(SecretSantaSpacing.md),
        decoration: BoxDecoration(
          gradient: SecretSantaColors.whatsAppGradient,
          borderRadius: BorderRadius.circular(SecretSantaRadius.lg),
          boxShadow: SecretSantaShadows.small,
        ),
        child: Row(
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: SecretSantaColors.neutral50,
                borderRadius: BorderRadius.circular(SecretSantaRadius.md),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Color(0xFF25D366), // verde do WhatsApp
                  size: 35,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.whatsappPremiumTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: SecretSantaColors.neutral50,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    !whatsAppPremium
                        ? l10n.whatsappPremiumCardSubtitle
                        : l10n.whatsappActivatedTitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: SecretSantaColors.neutral50,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              !whatsAppPremium ? Icons.chevron_right : Icons.verified,
              color: SecretSantaColors.neutral50,
            ),
          ],
        ),
      ),
    );
  }
}
