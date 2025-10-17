import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/database/group_db.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/create_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/update_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/status_auth_api.dart';
import 'package:sorteador_amigo_secreto/util/contants.dart';

class ParticipantDatasource extends ParticipantRepository {
  final dio = Dio(BaseOptions(headers: {'X-Tenant': xtenant}));

  @override
  Future<CreateParticipantModel> create(
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
      return model;
    } on DioException catch (e) {
      throw statusFallback(e.response?.statusCode);
    } catch (_) {
      throw Error;
    }
  }

  @override
  Future<ShowParticipantModel> show(int id) async {
    Response resp;
    try {
      resp = await dio.get(
        stageParticipantApiUrl,
        options: Options(headers: {'Authorization': bearerToken}),
      );
      final model = ShowParticipantModel.fromJson(resp.data);
      return model;
    } on DioException catch (e) {
      throw statusFallback(e.response?.statusCode);
    } catch (_) {
      throw Error;
    }
  }

  @override
  Future<UpdateParticipantModel> update(
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
      return UpdateParticipantModel.fromJson(resp.data);
    } on DioException catch (e) {
      throw statusFallback(e.response?.statusCode);
    } catch (_) {
      throw Error();
    }
  }
}
