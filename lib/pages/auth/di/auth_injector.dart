import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/datasource/auth_datasource.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/device/device_info.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/repository/auth_repository.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/usecases/auth_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';

void authInjectors() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthDatasource());
  getIt.registerLazySingleton<AuthDB>(
    () => AuthDB(getIt<SharedPreferencesWithCache>()),
  );
  getIt.registerFactory(() => AuthUsecases(getIt<AuthRepository>()));
  getIt.registerFactory(
    () => AuthCubit(
      getIt<AuthUsecases>(),
      getIt<AuthDB>(),
      getIt<DeviceData>(),
    ),
  );
}
