import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';

abstract class GroupRepository {
  Future<ApiResult<GroupModel>> create(CreateGroupEntity entity);
  Future<ApiResult<String>> delete(String code, String token);
  Future<ApiResult<GroupModel>> show(String code, String token);
  Future<ApiResult<GroupModel>> update(UpdateGroupEntity entity, String code, String token);
  Future<ApiResult<String>> raffle(String code, String token);
}
