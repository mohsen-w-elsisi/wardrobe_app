import 'package:hive_flutter/hive_flutter.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/persistance/hive_storable_cloth_item.dart';
import 'package:wardrobe_app/cloth_item/domain/data_gateway.dart';

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
  Future<void> delete(String id) async => _box.delete(id);

  @override
  Future<void> deleteAll() async => _box.clear();

  @override
  Future<Iterable<ClothItem>> getAllItems() async {
    return _box.values.map((item) => item.toClothItem());
  }

  @override
  Future<ClothItem> getById(String id) async {
    final item = _box.get(id);
    if (item == null) throw StateError(_itemNotFoundErrorMessage);
    return item.toClothItem();
  }

  @override
  Future<void> save(ClothItem item) async {
    _box.put(
      item.id,
      HiveStorableClothItem.fromClothItem(item),
    );
  }
}
