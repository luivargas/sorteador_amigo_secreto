import 'dart:math';
import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/database/group_db.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/datasource/group_api_result.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/create_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/update_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';
import 'package:sorteador_amigo_secreto/core/network/contants.dart';

class GroupDatasource extends GroupRepository {
  final dio = Dio(BaseOptions(headers: {'Accept': 'application/json'}));

  @override
  Future<GroupApiResult<CreateGroupModel>> create(
    CreateGroupEntity entity,
  ) async {
    Response resp;
    try {
      resp = await dio.post(stageGroupApiUrl, data: entity.toJson());
      final model = CreateGroupModel.fromJson(resp.data);
      await GroupDB().create(model);
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

  @override
  Future<void> delete(int id) async {
    final token = await GroupDB().getAdminIdById(id);
    try {
      await dio.delete(
        stageGroupApiUrl,
        options: Options(headers: {'Access-Key': token}),
      );
      await GroupDB().delete(id);
    } catch (_) {}
  }

  @override
  Future<GroupApiResult<ShowGroupModel>> show(int id) async {
    final token = await GroupDB().getAccesKeyById(id);
    final code = await GroupDB().getCodeById(id);
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
  Future<GroupApiResult<UpdateGroupModel>> update(
    UpdateGroupEntity entity,
    int id,
  ) async {
    try {
      final token = await GroupDB().getAccesKeyById(id);
      final code = await GroupDB().getCodeById(id);
      final resp = await dio.put(
        '$stageGroupApiUrl/$code',
        data: entity.toJson(),
        options: Options(
          headers: {'Authorization': bearerToken, 'Access-Key': token},
        ),
      );
      final model = UpdateGroupModel.fromJson(resp.data);
      await GroupDB().update(model, id);
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
      return Failure(ApiError('Erro inesperado', raw: e));
    }
  }

  // @override
  // Future<CreateGroupModel> archive(CreateGroupEntity entity) async {
  //   final resp = await dio.post(
  //     '$stageGroupApiUrl/$entity/archive',
  //     data: entity.toJson(),
  //     options: Options(),
  //   );
  //   return CreateGroupModel.fromJson(resp.data);
  // }

  // @override
  // Future<CreateGroupModel> unArchive(CreateGroupEntity entity) async {
  //   final resp = await dio.post(
  //     '$stageGroupApiUrl/$entity/unarchive',
  //     data: entity.toJson(),
  //     options: Options(),
  //   );
  //   return CreateGroupModel.fromJson(resp.data);
  // }

  @override
  Future<GroupApiResult<String>> raffle(String code, int id) async {
    try {
      final token = await GroupDB().getAccesKeyById(id);
      final resp = await dio.post(
        '$stageGroupApiUrl/$code/raffle',
        options: Options(
          headers: {'Authorization': bearerToken, 'Access-Key': token},
        ),
      );
      return Success(resp.statusMessage!);
    } on DioException catch (e) {
      return Failure(
        ApiError(
          e.message ?? 'Erro inesperado',
          statusCode: e.response?.statusCode,
          raw: e.response?.data,
        ),
      );
    } catch (_) {
      return Failure(ApiError('Erro inesperado', raw: e));
    }
  }

  // @override
  // Future<CreateGroupModel> redraw(CreateGroupEntity entity) async {
  //   final resp = await dio.post(
  //     '$stageGroupApiUrl/$entity/redraw',
  //     data: entity.toJson(),
  //     options: Options(),
  //   );
  //   return CreateGroupModel.fromJson(resp.data);
  // }
}
