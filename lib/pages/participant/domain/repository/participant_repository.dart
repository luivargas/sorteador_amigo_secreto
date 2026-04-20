import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';

abstract class ParticipantRepository {
  Future<ApiResult<ParticipantModel>> create(
    CreateParticipantEntity entity,
    String token,
  );
  Future<ApiResult<ParticipantModel>> update(
    UpdateParticipantEntity entity,
    String id,
    String token,
  );
  Future<ApiResult<ParticipantModel>> show(String id, String token);
  Future<ApiResult> delete(String id, String token);
  Future<ApiResult> resendEmail(String id, String token);
}
