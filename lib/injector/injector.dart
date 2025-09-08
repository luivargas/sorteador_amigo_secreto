import 'package:get_it/get_it.dart';
import 'package:sorteador_amigo_secreto/pages/auth/di/auth_injector.dart';

final GetIt getIt = GetIt.instance;

class Injector {
  Injector() {
    initializeInjectors();
  }
  initializeInjectors() {
    authInjectors();
  }
}