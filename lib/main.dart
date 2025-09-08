import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/routes/routes.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  Injector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return MaterialApp.router(
          title: 'Sorteador Amigo Secreto',
          theme: myTheme,
          routerConfig: routes,
        );
      },
    );
  }
}
