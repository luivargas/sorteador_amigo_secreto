import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/create_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/isar_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';

class GroupDB {
  late Future<Isar> db;

  GroupDB() {
    db = openDB();
  }

  Future<int> create(CreateGroupModel result) async {
    final isar = await db;
    final group = IsarGroupModel()
      ..name = result.name
      ..shortCode = result.shortCode
      ..code = result.code
      ..token = result.token
      ..status = result.status
      ..adminId = result.participants[0].id;
    return isar.writeTxnSync(() => isar.isarGroupModels.putSync(group));
  }

  Future<bool> delete(int id) async {
    final isar = await db;
    final result = await isar.writeTxn(
      () async => await isar.isarGroupModels.delete(id),
    );
    return result;
  }

  Future<String> getAccesKeyById(int id) async {
    final isar = await db;
    final group = await isar.isarGroupModels.get(id);
    return group!.token;
  }

  Future<String> getCodeById(int id) async {
    final isar = await db;
    final group = await isar.isarGroupModels.get(id);
    return group!.code;
  }

  Future<String> getAdminIdById(int id) async {
    final isar = await db;
    final group = await isar.isarGroupModels.get(id);
    return group!.adminId;
  }

  Future<List<IsarGroupModel>> getAllGroups() async {
    final isar = await db;
    final group = await isar.isarGroupModels.where().findAll();
    group.map((e) => e.toDomain()).toList();
    return group;
  }

  Future<List<IsarGroupModel>> getAllActiveGroups() async {
    final isar = await db;
    final group = await isar.isarGroupModels
        .where()
        .filter()
        .statusEqualTo('active')
        .findAll();
    group.map((e) => e.toDomain()).toList();
    return group;
  }

  Future<List<IsarGroupModel>> getAllArchivedGroups() async {
    final isar = await db;
    final group = await isar.isarGroupModels
        .where()
        .filter()
        .statusEqualTo('archived')
        .findAll();
    group.map((e) => e.toDomain()).toList();
    return group;
  }

  Future<int> countAllGroups() async {
    final isar = await db;
    final group = isar.isarGroupModels.where().count();
    return group;
  }

  Stream<List<ShowGroupModel>> listenToGroups() async* {
    final isar = await db;
    yield* isar.isarGroupModels
        .where()
        .watch(fireImmediately: true)
        .map((list) => list.map((e) => e.toDomain()).toList());
  }

  Future<QueryBuilder<IsarGroupModel, IsarGroupModel, QAfterFilterCondition>>
  getByName(String name) async {
    final isar = await db;
    final filteredGrop = isar.isarGroupModels.filter().nameEqualTo(name);
    return filteredGrop;
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [IsarGroupModelSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
