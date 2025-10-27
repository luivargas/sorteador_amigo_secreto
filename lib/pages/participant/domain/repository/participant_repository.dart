import 'package:sorteador_amigo_secreto/pages/participant/data/datasource/participant_api_result.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/create_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/update_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';

abstract class ParticipantRepository {
  Future<ParticipantApiResult<CreateParticipantModel>>create(CreateParticipantEntity entity, int id);
  Future<ParticipantApiResult<UpdateParticipantModel>>update(UpdateParticipantEntity entity, int id);
  Future<ParticipantApiResult<ShowParticipantModel>>show(int id);
}