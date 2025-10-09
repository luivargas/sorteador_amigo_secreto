import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/create_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/update_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';
import 'package:sorteador_amigo_secreto/util/contants.dart';

class ParticipantDatasource extends ParticipantRepository{
  final dio = Dio(BaseOptions(headers: {'X-Tenant': xtenant}));

  @override
  Future<CreateParticipantModel> create(CreateParticipantEntity entity, int id) async {
    Response resp;
    try {
      resp = await dio.post(stageGroupApiUrl, data: entity.toJson());
      final model = CreateParticipantModel.fromJson(resp.data);
      return model;
    } on DioException {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ShowParticipantModel> show(int id) async {
    try {
      final resp = await dio.get(
        stageGroupApiUrl,
        options: Options(
          headers: {'Authorization': bearerToken},
        ),
      );
      final model = ShowParticipantModel.fromJson(resp.data);
      return model;
    } on DioException {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UpdateParticipantModel> update(UpdateParticipantEntity entity, int id) async {
    try{
      final resp = await dio.put(
        '$stageGroupApiUrl/$id',
        data: entity.toJson(),
        options: Options(
          headers: {'Authorization': bearerToken},
        ),
      );
      return UpdateParticipantModel.fromJson(resp.data);
    } on DioException {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}