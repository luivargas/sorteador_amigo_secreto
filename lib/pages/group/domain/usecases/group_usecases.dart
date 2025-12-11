import 'package:sorteador_amigo_secreto/pages/group/data/datasource/group_api_result.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/create_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/update_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/update_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';

class GroupUsecases {
  final GroupRepository repository;
  GroupUsecases(this.repository);

  Future<GroupApiResult<CreateGroupModel>> create(CreateGroupEntity entity) =>
      repository.create(entity);
  Future<void> delete(int id) => repository.delete(id);
  Future<GroupApiResult<ShowGroupModel>> show(int id) => repository.show(id);
  Future<GroupApiResult<UpdateGroupModel>> update(
    UpdateGroupEntity entity,
    int id,
  ) => repository.update(entity, id);
  Future<GroupApiResult<String>>raffle(String code,int id) => repository.raffle(code, id );
}
