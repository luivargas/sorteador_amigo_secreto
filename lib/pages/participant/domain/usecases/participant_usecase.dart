import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/create_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/update_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';

class ParticipantUsecase {
  final ParticipantRepository repository;
  ParticipantUsecase(this.repository);

  Future<ApiResult<CreateParticipantModel>> create(
    CreateParticipantEntity entity,
    String groupToken,
  ) => repository.create(entity, groupToken);

  Future<ApiResult<UpdateParticipantModel>> update(
    UpdateParticipantEntity entity,
    String id,
    String groupToken,
  ) => repository.update(entity, id, groupToken);

  Future<ApiResult<ShowParticipantModel>> show(String id, String groupToken) =>
      repository.show(id, groupToken);
}
