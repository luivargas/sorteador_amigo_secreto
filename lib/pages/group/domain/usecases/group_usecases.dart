import 'package:sorteador_amigo_secreto/pages/group/data/model/create_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/repository/group_repository.dart';

class GroupUsecases {
  final GroupRepository repository;
  GroupUsecases(this.repository);
  
  Future<void> create(CreateGroupEntity entity) => repository.create(entity);
}