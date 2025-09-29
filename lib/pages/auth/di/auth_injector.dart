import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/datasource/auth_datasource.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/repository/auth_repository.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/usecases/auth_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/auth/presentation/cubit/auth_cubit.dart';

void authInjectors() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthDatasource());
  getIt.registerLazySingleton(() => AuthUsecases(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => AuthCubit(getIt<AuthUsecases>()));
}
