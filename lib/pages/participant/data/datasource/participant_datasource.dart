import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/core/network/api_error_mapper.dart';
import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';
import 'package:sorteador_amigo_secreto/core/network/url/contants.dart';

class ParticipantDatasource extends ParticipantRepository {
  final dio = Dio(BaseOptions(headers: {'Accept': 'application/json'}));

  @override
  Future<ApiResult<ParticipantModel>> create(
    CreateParticipantEntity entity,
    String groupToken,
  ) async {
    try {
      final resp = await dio.post(
        stageParticipantApiUrl,
        data: entity.toJson(),
        options: Options(headers: {'Access-Key': groupToken}),
      );
      final model = ParticipantModel.fromJson(resp.data);
      return Success(model);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          ApiErrorMapper.map(e),
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(ApiError(AppError.unknown, raw: e));
    }
  }

  @override
  Future<ApiResult<ParticipantModel>> show(String id, String token) async {
    try {
      final resp = await dio.get(
        '$stageParticipantApiUrl/$id',
        options: Options(headers: {'Access-Key': token}),
      );
      final model = ParticipantModel.fromJson(resp.data);
      return Success(model);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          ApiErrorMapper.map(e),
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(ApiError(AppError.unknown, raw: e));
    }
  }

  @override
  Future<ApiResult<ParticipantModel>> update(
    UpdateParticipantEntity entity,
    String id,
    String token,
  ) async {
    try {
      final resp = await dio.put(
        '$stageParticipantApiUrl/$id',
        data: entity.toJson(),
        options: Options(headers: {'Access-Key': token}),
      );
      final model = ParticipantModel.fromJson(resp.data);
      return Success(model);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          ApiErrorMapper.map(e),
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(ApiError(AppError.unknown, raw: e));
    }
  }

  @override
  Future<ApiResult> delete(String id, String token) async {
    try {
      final resp = await dio.delete(
        '$stageParticipantApiUrl/$id',
        options: Options(headers: {'Access-Key': token}),
      );
      return Success(resp);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          ApiErrorMapper.map(e),
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(ApiError(AppError.unknown, raw: e));
    }
  }

    @override
  Future<ApiResult> resendEmail(String id, String token) async {
    try {
      final resp = await dio.post(
        '$stageParticipantApiUrl/$id/resend-email',
        options: Options(headers: {'Access-Key': token}),
      );
      return Success(resp);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          ApiErrorMapper.map(e),
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(ApiError(AppError.unknown, raw: e));
    }
  }
}
