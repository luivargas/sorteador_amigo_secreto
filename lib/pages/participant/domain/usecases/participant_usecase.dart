import 'package:sorteador_amigo_secreto/pages/participant/data/datasource/participant_api_result.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/create_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/update_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';

class ParticipantUsecase {
  final ParticipantRepository repository;
  ParticipantUsecase(this.repository);
  Future<ParticipantApiResult<CreateParticipantModel>> create(
    CreateParticipantEntity entity,
    int groupId,
  ) => repository.create(entity, groupId);
  Future<ParticipantApiResult<UpdateParticipantModel>> update(
    UpdateParticipantEntity entity,
    int groupId,
  ) => repository.update(entity, groupId);
  Future<ParticipantApiResult<ShowParticipantModel>> show(String id, String groupAccessKey) =>
      repository.show( id, groupAccessKey);
}
