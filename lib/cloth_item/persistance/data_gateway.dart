import 'package:hive_flutter/hive_flutter.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/persistance/hive_storable_cloth_item.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

class ClothItemHiveDataGateway extends ClothItemDataGateway {
  static const _boxName = "ClothItems";

  late final Box<ClothItem> _box;

  Future<void> initialise() async {
    Hive.registerAdapter(HiveStorableClothItemAdapter());
    _box = await Hive.openBox(_boxName);
  }

  @override
  void delete(String id) {
    _box.delete(id);
  }

  @override
  void deleteAll() {
    _box.clear();
  }

  @override
  Iterable<ClothItem> getAllItems() {
    return _box.values;
  }

  @override
  ClothItem getById(String id) {
    return _box.get(id)!;
  }

  @override
  void save(ClothItem item) {
    _box.put(item.id, item);
  }
}
