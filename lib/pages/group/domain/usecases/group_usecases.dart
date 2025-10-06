import 'package:sorteador_amigo_secreto/pages/group/data/model/group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';

class GroupUsecases {
  final GroupRepository repository;
  GroupUsecases(this.repository);
  
  Future<GroupModel> create(CreateGroupEntity entity) => repository.create(entity);
  Future<GroupModel> delete(int id) => repository.delete(id);
  Future<ShowGroupModel> show(int id) => repository.show(id);
}