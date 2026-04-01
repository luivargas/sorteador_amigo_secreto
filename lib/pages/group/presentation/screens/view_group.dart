import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/core/network/base_url.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/view_group/view_group_card.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ViewGroup extends StatefulWidget {
  final String code;
  final String token;
  final String? name;
  const ViewGroup({super.key, required this.code, required this.token, this.name});

  @override
  State<ViewGroup> createState() => _ViewGroupBody();
}

class _ViewGroupBody extends State<ViewGroup> {
  final RefreshController _refreshController = RefreshController();
  ShowGroupModel? group;

  Future<void> _onShare(ShowGroupModel? g) async {
    final title = AppLocalizations.of(context)!.shareLinkTitle;
    await SharePlus.instance.share(
      ShareParams(
        uri: Uri.parse("$stgBaseUrl/grupo/${g?.code}/entrar"),
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
    if (result == true) {
      context.read<GroupCubit>().show(widget.code, widget.token);
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


  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBar(
        actions: [
          IconButton(
            onPressed: _onEdit,
            icon: const Icon(Icons.edit_outlined, size: 24),
            tooltip: AppLocalizations.of(context)!.edit,
          ),
          IconButton(
            onPressed: () => _onShare(group),
            icon: const Icon(Icons.share_outlined, size: 24),
          ),
        ],
      ),
      body: BlocConsumer<GroupCubit, GroupState>(
        listenWhen: (previous, current) =>
            previous.isLoading && !current.isLoading && current.raffled,
        listener: (context, state) => _onRefresh(),
        builder: (context, state) {
          if (state.isLoading && state.group == null) {
            return Center(
              child: CircularProgressIndicator(color: myProgressIndicator.color),
            );
          }
          if (state.error != null) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: Text(state.error!.localize(context)),
            );
          }
          if (state.group != null) {
            group = state.group!;
          }
          if (group == null) return const SizedBox.shrink();

          final g = group!;
          final type = g.raffledAt == null ? BadgeType.pending : BadgeType.raffled;

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
                  eventLocation: g.location ?? AppLocalizations.of(context)!.notDefined,
                  minGiftValue: g.minGiftValue ?? "00,00",
                  maxGiftValue: g.maxGiftValue ?? "00,00",
                  eventDate: _formatDate(g.drawDate),
                  eventTime: g.drawDate?.split(' ').last ?? "--:--",
                  groupDescription:
                      g.description ?? AppLocalizations.of(context)!.noDescription,
                  participants: g.participants.length,
                  participantsList: g.participants,
                  groupToken: g.token,
                  groupCode: g.code,
                ),
                if (g.raffledAt == null && g.participants.length >= 2) ...[
                  const SizedBox(height: 24),
                  MyGradientButton(
                    onTap: () => _onSubmit(g.code),
                    title: AppLocalizations.of(context)!.drawButton,
                    icon: Icons.draw,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

// Hero header com gradiente — substitui o badge solto + botão de editar inline
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
              gradient: MyColors.primaryGradient,
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
                  style: SecretSantaTextStyles.h3.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          // Ícone decorativo semi-transparente no canto direito
          Positioned(
            right: -16,
            top: -8,
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
