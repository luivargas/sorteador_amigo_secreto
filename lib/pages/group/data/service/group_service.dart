import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/create_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/isar_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';

class GroupService {
  late Future<Isar> db;

  GroupService() {
    db = openDB();
  }

  Future<void> addOne(CreateGroupModel result) async {
    final isar = await db;
    final group = IsarGroupModel()
      ..name = result.name
      ..shortCode = result.shortCode
      ..code = result.code
      ..token = result.token;
    isar.writeTxnSync(() => isar.isarGroupModels.putSync(group));
  }

  Future<void> delete(dynamic id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.isarGroupModels.delete(id);
    });
  }

  Future<String> getAccesKeyById(int id) async {
    final isar = await db;
    final group = await isar.isarGroupModels.get(id);
    return group!.token;
  }

  Future<List<IsarGroupModel>> getAllGroups() async {
    final isar = await db;
    final group = await isar.isarGroupModels.where().findAll();
    group.map((e) => e.toDomain()).toList();
    return group;
  }

    Future<int> countAllGroups() async {
    final isar = await db;
    final group = isar.isarGroupModels.where().count();
    print(group);
    return group;
  }

  Stream<List<ShowGroupModel>> listenToGroups() async* {
    final isar = await db;
    yield* isar.isarGroupModels.where().watch(fireImmediately: true).map((list) => list.map((e) => e.toDomain()).toList());
  }

  Future<QueryBuilder<IsarGroupModel, IsarGroupModel, QAfterFilterCondition>> getByName(String name) async {
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


