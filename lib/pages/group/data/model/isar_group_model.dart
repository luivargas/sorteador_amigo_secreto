// ignore_for_file: unused_element

import 'package:isar/isar.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';

part 'isar_group_model.g.dart';

@collection
@Name('Group')
class IsarGroupModel {
  Id id = Isar.autoIncrement;
  late String code;
  late String shortCode;
  late String name;
  late String token;
  late String adminId;
  // late String status;
}

extension IsarGroupToDomain on IsarGroupModel {
  ShowGroupModel toDomain() => ShowGroupModel(
    code: code,
    shortCode: shortCode,
    name: name,
    token: token,
    // status: status, 
    participants: [],
  );
}
