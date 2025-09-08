import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool participant = true;
  bool showRaffled = true;
  bool admin = true;
  Color activeColor = MyColors.sorteadorOrange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Filtros",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            activeThumbColor: activeColor,
            title: const Text("Grupos já sorteados"),
            value: showRaffled,
            onChanged: (val) => setState(() => showRaffled = val),
          ),
          SwitchListTile(
            activeThumbColor: activeColor,
            title: const Text("Grupos que participo"),
            value: participant,
            onChanged: (val) => setState(() => participant = val),
          ),
          SwitchListTile(
            activeThumbColor: activeColor,
            title: const Text("Grupos que administro"),
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
                child: const Text("Limpar"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    "active": participant,
                    "raffled": showRaffled,
                    "adminOnly": admin,
                  });
                },
                child: const Text("Aplicar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
