import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';

class GroupUsecases {
  final GroupRepository repository;
  GroupUsecases(this.repository);

  Future<ApiResult<GroupModel>> create(CreateGroupEntity entity) =>
      repository.create(entity);
  Future<ApiResult<GroupModel>> show(String code, String token) =>
      repository.show(code, token);
  Future<ApiResult<GroupModel>> update(
    UpdateGroupEntity entity,
    String code,
    String token,
  ) => repository.update(entity, code, token);
  Future<ApiResult<String>> raffle(String code, String token) =>
      repository.raffle(code, token);

  Future<ApiResult<String>> delete(String code, String token) =>
      repository.delete(code, token);
}
