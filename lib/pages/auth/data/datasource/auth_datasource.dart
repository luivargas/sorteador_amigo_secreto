import 'dart:math';
import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/core/network/base_url.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_model.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/request_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/validate_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/repository/auth_repository.dart';
import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/core/network/contants.dart';

class AuthDatasource extends AuthRepository {
  final dio = Dio(BaseOptions(headers: {'Accept': 'application/json'}));

  @override
  Future<ApiResult> request(
    RequestToken entity,
  ) async {
    Response resp;
    try {
      resp = await dio.post(stageGroupApiUrl, data: entity.toJson());
      print(resp);
      return Success(resp);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          e.message ?? 'Erro inesperado',
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (_) {
      return Failure(
        ApiError('Erro inesperado', statusCode: e.hashCode, raw: e),
      );
    }
  }

  @override
  Future<ApiResult<AuthModel>> validate(ValidateToken entity) async {
    try {
      final resp = await dio.get(
        validadeToken,
      );
      final model = AuthModel.fromJson(resp.data);
      print(model);
      return Success(model);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          e.message ?? 'Erro inesperado',
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (_) {
      return Failure(
        ApiError('Erro inesperado', statusCode: e.hashCode, raw: e),
      );
    }
  }
}
