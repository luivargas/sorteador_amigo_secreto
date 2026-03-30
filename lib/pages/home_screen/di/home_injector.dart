import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/device/device_info.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/usecases/auth_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/usecases/group_usecases.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/cubit/home_cubit.dart';

void homeInjectors() {
  getIt.registerFactory(
    () => HomeCubit(
      getIt<GroupUsecases>(),
      getIt<AuthUsecases>(),
      getIt<AuthDB>(),
      getIt<DeviceData>(),
    ),
  );
}
