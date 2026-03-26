import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/core/network/base_url.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_group_model.dart';
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
      return Failure(
        ApiError(
          e.message ?? 'Erro inesperado',
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(
        ApiError('Erro inesperado', statusCode: e.hashCode, raw: e),
      );
    }
  }

  @override
  Future<ApiResult<AuthGroupModel>> validate(ValidateToken entity) async {
    print(entity.toJson());
    try {
      final resp = await dio.post(
        validadeToken,
        data: entity.toJson(),
      );
      final model = AuthGroupModel.fromJson(resp.data);
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
      return Failure(
        ApiError('Erro inesperado', statusCode: e.hashCode, raw: e),
      );
    }
  }
}
