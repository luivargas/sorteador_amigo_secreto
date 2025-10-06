import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';

abstract class ParticipantRepository {
  Future<ParticipantModel>create(CreateParticipantEntity entity, int id);
  //Future<ParticipantModel>update(UpdateParticipantEntity entity, int id);
  Future<ParticipantModel>show(int id);
}