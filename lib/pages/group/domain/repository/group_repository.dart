import 'package:sorteador_amigo_secreto/pages/group/data/datasource/group_api_result.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/create_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/update_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';

abstract class GroupRepository {
  Future<GroupApiResult<CreateGroupModel>>create(CreateGroupEntity entity);
  Future<void>delete(int id);
  Future<GroupApiResult<ShowGroupModel>>show(int id);
  Future<GroupApiResult<UpdateGroupModel>>update(UpdateGroupEntity entity, int id);
}
