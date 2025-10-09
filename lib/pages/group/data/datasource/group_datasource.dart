import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/database/group_db.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/create_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/update_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';
import 'package:sorteador_amigo_secreto/util/contants.dart';

class GroupDatasource extends GroupRepository {
  final dio = Dio(BaseOptions(headers: {'X-Tenant': xtenant}));

  @override
  Future<CreateGroupModel> create(CreateGroupEntity entity) async {
    Response resp;
    try {
      resp = await dio.post(stageGroupApiUrl, data: entity.toJson());
      final created = CreateGroupModel.fromJson(resp.data);
      await GroupDB().createGroup(created);
      return created;
    } on DioException {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    final token = GroupDB().getAdminIdById(id);
    try {
      final resp = await dio.delete(
        stageGroupApiUrl,
        options: Options(
          headers: {'Authorization': bearerToken, 'Access-Key': token},
        ),
      );
      await GroupDB().delete(id);
    } on DioException {
    } catch (_) {}
  }

  @override
  Future<ShowGroupModel> show(int id) async {
    final token = GroupDB().getAccesKeyById(id);
    try {
      final resp = await dio.get(
        stageGroupApiUrl,
        options: Options(
          headers: {'Authorization': bearerToken, 'Access-Key': token},
        ),
      );
      final model = ShowGroupModel.fromJson(resp.data as Map<String, dynamic>);
      return model;
    } on DioException {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UpdateGroupModel> update(UpdateGroupEntity entity, int id) async {
    try{
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
    }catch (_){
      rethrow;
    }
  }

  @override
  Future<CreateGroupModel> archive(CreateGroupEntity entity) async {
    final resp = await dio.post(
      '$stageGroupApiUrl/${entity}/archive',
      data: entity.toJson(),
      options: Options(),
    );
    return CreateGroupModel.fromJson(resp.data);
  }

  @override
  Future<CreateGroupModel> unArchive(CreateGroupEntity entity) async {
    final resp = await dio.post(
      '$stageGroupApiUrl/${entity}/unarchive',
      data: entity.toJson(),
      options: Options(),
    );
    return CreateGroupModel.fromJson(resp.data);
  }

  @override
  Future<String?> raffle(int id) async {
    final acessKey = GroupDB().getAccesKeyById(id);
    final code = GroupDB().getCodeById(id);
    final resp = await dio.post(
      '$stageGroupApiUrl/$code/raffle',
      options: Options(
        headers: {'Authorization': bearerToken, 'Access-Key': acessKey},
      ),
    );
    return resp.statusMessage;
  }

  @override
  Future<CreateGroupModel> redraw(CreateGroupEntity entity) async {
    final resp = await dio.post(
      '$stageGroupApiUrl/${entity}/redraw',
      data: entity.toJson(),
      options: Options(),
    );
    return CreateGroupModel.fromJson(resp.data);
  }
}
