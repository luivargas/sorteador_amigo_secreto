import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/routes/routes.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return MaterialApp.router(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            ...PhoneFieldLocalization.delegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          title: 'Sorteador Amigo Secreto',
          theme: SecretSantaTheme.theme,
          routerConfig: routes,
          builder: (context, child) {
            return RefreshConfiguration(
              headerBuilder: () => WaterDropHeader(
                complete: Text(AppLocalizations.of(context)!.refreshCompleted),
                refresh: Text(AppLocalizations.of(context)!.refreshing),
                waterDropColor: SecretSantaColors.accent,
                completeDuration: const Duration(milliseconds: 800),
              ),
              footerBuilder: () => const ClassicFooter(),
              headerTriggerDistance: 80.0,
              springDescription: const SpringDescription(
                stiffness: 170,
                damping: 16,
                mass: 1.9,
              ),
              maxOverScrollExtent: 100,
              maxUnderScrollExtent: 0,
              enableScrollWhenRefreshCompleted: true,
              enableLoadingWhenFailed: true,
              hideFooterWhenNotFull: false,
              enableBallisticLoad: true,
              child: child!,
            );
          },
        );
      },
    );
  }
}
