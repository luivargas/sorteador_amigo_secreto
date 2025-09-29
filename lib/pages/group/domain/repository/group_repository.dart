import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';

abstract class GroupRepository {
  Future<void> create(CreateGroupEntity entity);
  Future<ShowGroupModel> show(int id);
}
