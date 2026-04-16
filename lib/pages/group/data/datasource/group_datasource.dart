
import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/core/network/api_error_mapper.dart';
import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/create_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/update_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';
import 'package:sorteador_amigo_secreto/core/network/url/contants.dart';

class GroupDatasource extends GroupRepository {
  final dio = Dio(BaseOptions(headers: {'Accept': 'application/json'}));
  final AuthDB authDB;

  GroupDatasource({required this.authDB});

  @override
  Future<ApiResult<CreateGroupModel>> create(CreateGroupEntity entity) async {
    try {
      final resp = await dio.post(stageGroupApiUrl, data: entity.toJson());
      final model = CreateGroupModel.fromJson(resp.data);
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
  Future<ApiResult<ShowGroupModel>> show(String code, String token) async {
    try {
      final resp = await dio.get(
        '$stageGroupApiUrl/$code',
        options: Options(headers: {'Access-Key': token}),
      );
      final model = ShowGroupModel.fromJson(resp.data);
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
  Future<ApiResult<UpdateGroupModel>> update(
    UpdateGroupEntity entity,
    String code,
    String token,
  ) async {
    try {
      final resp = await dio.put(
        '$stageGroupApiUrl/$code',
        data: entity.toJson(),
        options: Options(headers: {'Access-Key': token}),
      );
      final model = UpdateGroupModel.fromJson(resp.data);
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
        '$stageGroupApiUrl/$code/raffle',
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
      final email = authDB.email;
      final resp = await dio.post(
        '$stageGroupApiUrl/$code/disable',
        data: {'email': email},
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
