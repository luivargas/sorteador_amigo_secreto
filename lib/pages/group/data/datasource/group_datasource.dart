// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/create_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/service/group_service.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';
import 'package:sorteador_amigo_secreto/util/contants.dart';

class GroupDatasource extends GroupRepository {
  final dio = Dio(BaseOptions(headers: {'X-Tenant': xtenant}));

  @override
  Future<void> create(CreateGroupEntity entity) async {
    Response response;
    response = await dio.post(stageGroupApiUrl, data: entity.toJson());
    final raw = response.data;
    final model = CreateGroupModel.fromJson(raw);
    GroupService().addOne(model);
  }

  @override
  Future<CreateGroupModel> update(CreateGroupEntity entity) async {
    Response response;
    response = await dio.put(
      stageGroupApiUrl,
      options: Options(
        //headers: {'Authorization': bearerToken, 'Access-Key': token},
      ),
      data: entity.toJson(),
    );
    final raw = response.data;
    final model = CreateGroupModel.fromJson(raw);
    return model;
  }

  @override
  Future<ShowGroupModel> show(int id) async {
    var token =  GroupService().getAccesKeyById(id);
    Response response;
    response = await dio.get(
      stageGroupApiUrl,
      options: Options(
        headers: {'Authorization': bearerToken, 'Access-Key': token},
      ),
    );
    final raw = response.data;
    final model = ShowGroupModel.fromJson(raw);
    return model;
  }

  @override
  Future<CreateGroupModel> archive(CreateGroupEntity entity) async {
    Response response;
    response = await dio.post(
      stageGroupApiUrl,
      options: Options(
        //headers: {'Authorization': bearerToken, 'Access-Key': token},
      ),
      data: entity.toJson(),
    );
    final raw = response.data;
    final model = CreateGroupModel.fromJson(raw);
    return model;
  }

  @override
  Future<CreateGroupModel> unArchive(CreateGroupEntity entity) async {
    Response response;
    response = await dio.post(
      stageGroupApiUrl,
      options: Options(
        //headers: {'Authorization': bearerToken, 'Access-Key': token},
      ),
      data: entity.toJson(),
    );
    final raw = response.data;
    final model = CreateGroupModel.fromJson(raw);
    return model;
  }

  @override
  Future<CreateGroupModel> raffle(CreateGroupEntity entity) async {
    Response response;
    response = await dio.post(
      stageGroupApiUrl,
      options: Options(
        //headers: {'Authorization': bearerToken, 'Access-Key': token},
      ),
      data: entity.toJson(),
    );
    final raw = response.data;
    final model = CreateGroupModel.fromJson(raw);
    return model;
  }

  @override
  Future<CreateGroupModel> redraw(CreateGroupEntity entity) async {
    Response response;
    response = await dio.post(
      stageGroupApiUrl,
      options: Options(
        //headers: {'Authorization': bearerToken, 'Access-Key': token},
      ),
      data: entity.toJson(),
    );
    final raw = response.data;
    final model = CreateGroupModel.fromJson(raw);
    return model;
  }

  @override
  Future<void> delete() async {
    Response response;
    response = await dio.delete(
      stageGroupApiUrl,
      options: Options(
        //headers: {'Authorization': bearerToken, 'Access-Key': token},
      ),
    );
    final raw = response.data;
  }
}
