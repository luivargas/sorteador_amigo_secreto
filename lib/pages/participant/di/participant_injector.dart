import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/datasource/participant_datasource.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/usecases/participant_usecase.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';

void participantInjectors(){
  getIt.registerLazySingleton<ParticipantRepository>(() => ParticipantDatasource());
  getIt.registerFactory(() => ParticipantUsecase(getIt<ParticipantRepository>()));
  getIt.registerFactory(() => ParticipantCubit(getIt<ParticipantUsecase>()));
}