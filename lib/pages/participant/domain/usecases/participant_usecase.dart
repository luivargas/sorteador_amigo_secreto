import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';

class ParticipantUsecase {
  final ParticipantRepository repository;
  ParticipantUsecase(this.repository);

  Future<ApiResult<ParticipantModel>> create(
    CreateParticipantEntity entity,
    String token,
  ) => repository.create(entity, token);

  Future<ApiResult<ParticipantModel>> update(
    UpdateParticipantEntity entity,
    String id,
    String token,
  ) => repository.update(entity, id, token);

  Future<ApiResult<ParticipantModel>> show(String id, String token) =>
      repository.show(id, token);
  Future<ApiResult> delete(String id, String token) =>
      repository.delete(id, token);

  Future<ApiResult> resendEmail(String id, String token) =>
      repository.resendEmail(id, token);
}
