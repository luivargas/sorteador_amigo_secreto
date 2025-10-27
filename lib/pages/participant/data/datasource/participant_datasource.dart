import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/database/group_db.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/datasource/participant_api_result.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/create_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/update_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';
import 'package:sorteador_amigo_secreto/util/contants.dart';

class ParticipantDatasource extends ParticipantRepository {
  final dio = Dio(BaseOptions(headers: {'X-Tenant': xtenant}));

  @override
  Future<ParticipantApiResult<CreateParticipantModel>> create(
    CreateParticipantEntity entity,
    int groupId,
  ) async {
    Response resp;
    try {
      final token = await GroupDB().getAccesKeyById(groupId);
      resp = await dio.post(
        stageParticipantApiUrl,
        data: entity.toJson(),
        options: Options(headers: {'Access-Key': token}),
      );
      final model = CreateParticipantModel.fromJson(resp.data);
      return Success(model);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          e.message ?? 'Erro inesperado',
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(ApiError('Erro inesperado', raw: e));
    }
  }

  @override
  Future<ParticipantApiResult<ShowParticipantModel>> show(int id) async {
    Response resp;
    try {
      resp = await dio.get(
        stageParticipantApiUrl,
        options: Options(headers: {'Authorization': bearerToken}),
      );
      final model = ShowParticipantModel.fromJson(resp.data);
      return Success(model);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          e.message ?? 'Erro inesperado',
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(ApiError('Erro inesperado', raw: e));
    }
  }

  @override
  Future<ParticipantApiResult<UpdateParticipantModel>> update(
    UpdateParticipantEntity entity,
    int id,
  ) async {
    Response resp;
    try {
      resp = await dio.put(
        '$stageParticipantApiUrl/$id',
        data: entity.toJson(),
        options: Options(headers: {'Authorization': bearerToken}),
      );
      final model = UpdateParticipantModel.fromJson(resp.data);

      return Success(model);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          e.message ?? 'Erro inesperado',
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(ApiError('Erro inesperado', raw: e));
    }
  }
}
