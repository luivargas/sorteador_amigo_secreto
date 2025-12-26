import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/database/group_db.dart';
import 'package:sorteador_amigo_secreto/routes/routes.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GroupDB().db;
  Injector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return RefreshConfiguration(
          headerBuilder: 
           () => WaterDropHeader(
            complete: Text('Atualizado!'),
            refresh: Text("Atualizando..."),
            waterDropColor: MyColors.sorteadorOrange,
            completeDuration: Duration(milliseconds: 800),
          ), // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
          footerBuilder: () =>
              ClassicFooter(), // Configure default bottom indicator
          headerTriggerDistance:
              80.0, // header trigger refresh trigger distance
          springDescription: SpringDescription(
            stiffness: 170,
            damping: 16,
            mass: 1.9,
          ), // custom spring back animate,the props meaning see the flutter api
          maxOverScrollExtent:
              100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
          maxUnderScrollExtent: 0, // Maximum dragging range at the bottom
          enableScrollWhenRefreshCompleted:
              true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
          enableLoadingWhenFailed:
              true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
          hideFooterWhenNotFull:
              false, // Disable pull-up to load more functionality when Viewport is less than one screen
          enableBallisticLoad:
              true, // trigger load more by BallisticScrollActivity
          child: MaterialApp.router(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('pt', 'BR')],
            locale: const Locale('pt'),
            title: 'Sorteador Amigo Secreto',
            theme: myTheme,
            routerConfig: routes,
          ),
        );
      },
    );
  }
}
