import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/device/device_info.dart';
import 'package:sorteador_amigo_secreto/pages/auth/di/auth_injector.dart';
import 'package:sorteador_amigo_secreto/pages/group/di/group_injector.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/di/home_injector.dart';
import 'package:sorteador_amigo_secreto/pages/participant/di/participant_injector.dart';

final GetIt getIt = GetIt.instance;

class Injector {
  static Future<void> init() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
    getIt.registerSingleton<SharedPreferencesWithCache>(prefs);

    final deviceData = await DeviceInfo.collect();
    getIt.registerSingleton<DeviceData>(deviceData);

    authInjectors();
    groupInjectors();
    homeInjectors();
    participantInjectors();
  }
}
