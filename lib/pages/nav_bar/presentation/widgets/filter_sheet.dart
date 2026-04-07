import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool participant = true;
  bool showRaffled = true;
  bool admin = true;
  Color activeColor = SecretSantaColors.accent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.filterTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            activeThumbColor: activeColor,
            title: Text(l10n.filterRaffled),
            value: showRaffled,
            onChanged: (val) => setState(() => showRaffled = val),
          ),
          SwitchListTile(
            activeThumbColor: activeColor,
            title: Text(l10n.filterParticipating),
            value: participant,
            onChanged: (val) => setState(() => participant = val),
          ),
          SwitchListTile(
            activeThumbColor: activeColor,
            title: Text(l10n.filterManaging),
            value: admin,
            onChanged: (val) => setState(() => admin = val),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    participant = true;
                    showRaffled = true;
                    admin = true;
                  });
                },
                child: Text(l10n.filterClear),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    "active": participant,
                    "raffled": showRaffled,
                    "adminOnly": admin,
                  });
                },
                child: Text(l10n.filterApply),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
