import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/device/device_info.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/usecases/auth_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/datasource/group_datasource.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/usecases/group_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';

void groupInjectors() {
  getIt.registerLazySingleton<GroupRepository>(
    () => GroupDatasource(),
  );
  getIt.registerLazySingleton(() => GroupSession());
  getIt.registerLazySingleton(() => GroupUsecases(getIt<GroupRepository>()));
  getIt.registerFactory(
    () => GroupCubit(
      getIt<GroupUsecases>(),
      getIt<AuthUsecases>(),
      getIt<AuthDB>(),
      getIt<DeviceData>(),
      getIt<GroupSession>(),
    ),
  );
}
