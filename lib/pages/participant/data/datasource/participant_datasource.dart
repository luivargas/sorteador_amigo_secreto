import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/database/group_db.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/update_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/create_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';
import 'package:sorteador_amigo_secreto/util/contants.dart';

/// Exceção tipada para métodos que retornam DADOS (ex.: show) e precisam falhar "forte".
class Apifailure implements Exception {
  final String message;
  final int? statusCode;
  final OperationStage stage;
  final Map<String, String>? fieldErrors;

  Apifailure(
    this.message, {
    this.statusCode,
    this.stage = OperationStage.api,
    this.fieldErrors,
  });

  @override
  String toString() =>
      'Apifailure(stage=$stage, status=$statusCode, message=$message, fieldErrors=$fieldErrors)';
}

/// Extensão para facilitar checagem de 2xx.
extension ResponseX on Response {
  bool get is2xx => (statusCode ?? 0) >= 200 && (statusCode ?? 0) < 300;
}

class ParticipantDatasource extends ParticipantRepository {
  final dio = Dio(BaseOptions(headers: {'X-Tenant': xtenant}));

  // ----------------- Helpers privados (DRY) -----------------

  Map<String, String>? _parseFieldErrors(dynamic data) {
    if (data is Map && data['errors'] is Map) {
      final Map fe = data['errors'] as Map;
      return fe.map((k, v) {
        final first = (v is List && v.isNotEmpty)
            ? v.first.toString()
            : v.toString();
        return MapEntry(k.toString(), first);
      }).cast<String, String>();
    }
    return null;
  }

  ParticipantModel _failureFromDio(
    DioException e, {
    OperationStage stage = OperationStage.api,
  }) {
    final sc = e.response?.statusCode;
    final data = e.response?.data;
    final msg = (data is Map && data['message'] != null)
        ? data['message'].toString()
        : (e.message ?? 'Erro na requisição');

    return ParticipantModel.failure(
      statusCode: sc,
      stage: stage,
      message: msg,
      fieldErrors: _parseFieldErrors(data),
    );
  }

  Apifailure _apifailureFromDio(DioException e) {
    final sc = e.response?.statusCode;
    final data = e.response?.data;
    final msg = (data is Map && data['message'] != null)
        ? data['message'].toString()
        : (e.message ?? 'Erro na requisição');

    return Apifailure(
      msg,
      statusCode: sc,
      stage: OperationStage.api,
      fieldErrors: _parseFieldErrors(data),
    );
  }

  // ----------------- Implementações -----------------

  @override
  Future<ParticipantModel> create(
    CreateParticipantEntity entity,
    int id,
  ) async {
    final adminId = GroupDB().getAdminIdById(id);
    try {
      final resp = await dio.post(
        '$stageParticipantApiUrl/$adminId',
        data: entity.toJson(),
        options: Options(headers: {'Authorization': bearerToken}),
      );

      if (!resp.is2xx) {
        return ParticipantModel.failure(
          statusCode: resp.statusCode,
          stage: OperationStage.api,
          message: resp.statusMessage ?? 'Falha na API',
          fieldErrors: _parseFieldErrors(resp.data),
        );
      }

      final created = CreateParticipantModel.fromJson(resp.data);

      return ParticipantModel.success(
        statusCode: resp.statusCode,
        stage: OperationStage.both,
        message: resp.statusMessage ?? 'Grupo criado com sucesso',
      );
    } on DioException catch (e) {
      return _failureFromDio(e);
    } catch (e) {
      return ParticipantModel.failure(
        stage: OperationStage.unknown,
        message: 'Erro inesperado: $e',
      );
    }
  }

  @override
  Future<ParticipantModel> delete(int id) async {
    final token = GroupDB().getAdminIdById(id);
    try {
      final resp = await dio.delete(
        stageGroupApiUrl,
        options: Options(
          headers: {'Authorization': bearerToken, 'Access-Key': token},
        ),
      );

      if (!resp.is2xx) {
        return ParticipantModel.failure(
          statusCode: resp.statusCode,
          stage: OperationStage.api,
          message: resp.statusMessage ?? 'Falha na API',
          fieldErrors: _parseFieldErrors(resp.data),
        );
      }

      try {
        await GroupDB().delete(id);
      } catch (dbErr) {
        return ParticipantModel.failure(
          stage: OperationStage.db,
          message: 'Falha ao remover no banco local: $dbErr',
        );
      }

      return ParticipantModel.success(
        statusCode: resp.statusCode,
        stage: OperationStage.both,
        message: resp.statusMessage ?? 'Grupo excluído com sucesso',
      );
    } on DioException catch (e) {
      return _failureFromDio(e);
    } catch (e) {
      return ParticipantModel.failure(
        stage: OperationStage.unknown,
        message: 'Erro inesperado: $e',
      );
    }
  }

  @override
  Future<ParticipantModel> show(int id) async {
    final token = GroupDB().getAccesKeyById(id);
    try {
      final resp = await dio.get(
        stageGroupApiUrl,
        options: Options(
          headers: {'Authorization': bearerToken, 'Access-Key': token},
        ),
      );

      if (!resp.is2xx) {
        throw Apifailure(
          resp.statusMessage ?? 'Falha na API',
          statusCode: resp.statusCode,
          stage: OperationStage.api,
          fieldErrors: _parseFieldErrors(resp.data),
        );
      }

      if (resp.data is! Map<String, dynamic>) {
        throw Apifailure(
          'Formato de resposta inválido',
          statusCode: resp.statusCode,
        );
      }

      final model = ShowGroupModel.fromJson(resp.data as Map<String, dynamic>);

      // Sanity checks mínimos — ajuste conforme seu contrato:
      final hasId = (model.code.toString().isNotEmpty);
      final hasName = (model.name.toString().isNotEmpty);
      if (!hasId || !hasName) {
        throw Apifailure(
          'Dados do grupo incompletos',
          statusCode: resp.statusCode,
        );
      }

      return model;
    } on DioException catch (e) {
      throw _apifailureFromDio(e);
    }
  }

  @override
  Future<UpdateGroupModel> update(UpdateGroupEntity entity, int id) async {
    final acessKey = GroupDB().getAccesKeyById(id);
    final code = GroupDB().getCodeById(id);
    final resp = await dio.post(
      '$stageGroupApiUrl/$code/raffle',
      data: entity.toJson(),
      options: Options(
        headers: {'Authorization': bearerToken, 'Access-Key': acessKey},
      ),
    );
    return UpdateGroupModel.fromJson(resp.data);
  }
}
