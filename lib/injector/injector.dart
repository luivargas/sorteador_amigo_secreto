import 'package:get_it/get_it.dart';
import 'package:sorteador_amigo_secreto/pages/group/di/group_injector.dart';
import 'package:sorteador_amigo_secreto/pages/participant/di/participant_injector.dart';

final GetIt getIt = GetIt.instance;

class Injector {
  Injector() {
    initializeInjectors();
  }
  void initializeInjectors() {
    groupInjectors();
    participantInjectors();
  }
}