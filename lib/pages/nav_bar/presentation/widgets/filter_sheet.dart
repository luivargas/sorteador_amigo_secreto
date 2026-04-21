import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
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
    final i18n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(SecretSantaSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            i18n.filterTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            activeThumbColor: activeColor,
            title: Text(i18n.filterRaffled),
            value: showRaffled,
            onChanged: (val) => setState(() => showRaffled = val),
          ),
          SwitchListTile(
            activeThumbColor: activeColor,
            title: Text(i18n.filterParticipating),
            value: participant,
            onChanged: (val) => setState(() => participant = val),
          ),
          SwitchListTile(
            activeThumbColor: activeColor,
            title: Text(i18n.filterManaging),
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
                child: Text(i18n.filterClear),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    "active": participant,
                    "raffled": showRaffled,
                    "adminOnly": admin,
                  });
                },
                child: Text(i18n.filterApply),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
