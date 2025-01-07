import 'package:hive_flutter/hive_flutter.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/persistance/hive_storable_cloth_item.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

class ClothItemHiveDataGateway extends ClothItemDataGateway {
  static const _boxName = "ClothItems";
  static const _itemNotFoundErrorMessage =
      "attempted to query cloth item that does not exist in Hive";

  late final Box<HiveStorableClothItem> _box;

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
    return _box.values.map((item) => item.toClothItem());
  }

  @override
  ClothItem getById(String id) {
    final item = _box.get(id);
    if (item == null) throw StateError(_itemNotFoundErrorMessage);
    return item.toClothItem();
  }

  @override
  void save(ClothItem item) {
    _box.put(
      item.id,
      HiveStorableClothItem.fromClothItem(item),
    );
  }
}
