
import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/core/network/api_error_mapper.dart';
import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';
import 'package:sorteador_amigo_secreto/core/network/url/contants.dart';

class GroupDatasource extends GroupRepository {
  final dio = Dio(BaseOptions(headers: {'Accept': 'application/json'}));


  @override
  Future<ApiResult<GroupModel>> create(CreateGroupEntity entity) async {
    try {
      final resp = await dio.post(prodGroupApiUrl, data: entity.toJson());
      final model = GroupModel.fromJson(resp.data);
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
  Future<ApiResult<GroupModel>> show(String code, String token) async {
    try {
      final resp = await dio.get(
        '$prodGroupApiUrl/$code',
        options: Options(headers: {'Access-Key': token}),
      );
      final model = GroupModel.fromJson(resp.data);
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
  Future<ApiResult<GroupModel>> update(
    UpdateGroupEntity entity,
    String code,
    String token,
  ) async {
    try {
      final resp = await dio.put(
        '$prodGroupApiUrl/$code',
        data: entity.toJson(),
        options: Options(headers: {'Access-Key': token}),
      );
      final model = GroupModel.fromJson(resp.data);
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
  Future<ApiResult<String>> raffle(String code, String token) async {
    try {
      final resp = await dio.post(
        '$prodGroupApiUrl/$code/raffle',
        options: Options(headers: {'Access-Key': token}),
      );
      return Success(resp.statusMessage ?? 'OK');
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
  Future<ApiResult<String>> delete(String code, String token) async {
    try {
      final resp = await dio.delete(
        '$prodGroupApiUrl/$code',
        options: Options(headers: {'Access-Key': token}),
      );
      return Success(resp.statusMessage ?? 'OK');
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
