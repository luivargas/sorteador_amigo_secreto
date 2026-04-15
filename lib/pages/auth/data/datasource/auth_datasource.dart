import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/core/network/api_error_mapper.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/core/network/url/base_url.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';

import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/request_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/validate_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/repository/auth_repository.dart';
import 'package:sorteador_amigo_secreto/core/network/api_result.dart';

class AuthDatasource extends AuthRepository {
  final dio = Dio(BaseOptions(headers: {'Accept': 'application/json'}));

  @override
  Future<ApiResult> request(
    RequestToken entity,
  ) async {
    Response resp;
    try {
      resp = await dio.post(requestToken, data: entity.toJson());
      return Success(resp);
    } on DioException catch (e) {
      return Failure(ApiError(
        ApiErrorMapper.map(e),
        statusCode: e.response?.statusCode,
        raw: e.response?.data,
      ));
    } catch (e) {
      return Failure(ApiError(AppError.unknown, raw: e));
    }
  }

  @override
  Future<ApiResult<List<AuthGroupModel>>> validate(ValidateToken entity) async {
    try {
      final resp = await dio.post(
        validateToken,
        data: entity.toJson(),
      );
      final model = (resp.data['groups'] as List)
          .map((e) => AuthGroupModel.fromJson(e))
          .toList();
      return Success(model);
    } on DioException catch (e) {
      return Failure(ApiError(
        ApiErrorMapper.map(e),
        statusCode: e.response?.statusCode,
        raw: e.response?.data,
      ));
    } catch (e) {
      return Failure(ApiError(AppError.unknown, raw: e));
    }
  }
}
