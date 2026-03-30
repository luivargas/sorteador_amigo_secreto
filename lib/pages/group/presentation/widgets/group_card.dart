import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/cubit/home_cubit.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class GroupCard extends StatefulWidget {
  final String groupName;
  final String groupToken;
  final String groupCode;
  final int index;
  final VoidCallback? onShare;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.groupToken,
    required this.groupCode,
    required this.index,
    this.onShare,
  });

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  Future<void> _delete(BuildContext ctx) async {
    Slidable.of(ctx)?.close();
    await context.read<HomeCubit>().deleteGroup(widget.groupToken, widget.groupCode);
  }

  Text _initials() {
    final text = widget.groupName.trim();
    final parts = text.split(' ').where((p) => p.isNotEmpty).toList();
    final first = parts.first[0].toUpperCase();
    final last = parts.length > 1 ? parts.last[0].toUpperCase() : '';
    return Text(
      '$first$last',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.groupCode),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: _delete,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete),
                Text('Excluir', overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          SlidableAction(
            onPressed: (_) => widget.onShare?.call(),
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: "Share",
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Arquivar',
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: MyColors.sorteadorGradient,
                    borderRadius: BorderRadius.circular(90),
                  ),
                  width: 60,
                  height: 60,
                  child: Center(child: _initials()),
                ),
              ),
              Expanded(
                child: Text(
                  widget.groupName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: MyColors.sorteadorOrange,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
