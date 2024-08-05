import 'package:hive_flutter/hive_flutter.dart';

import 'cloth_item.dart';
import 'cloth_item_manager.dart';

class HiveClothItemStorageAgent implements ClothItemStorageAgent {
  static const boxName = "cloth items";

  late final Box<ClothItem> _box;

  Future<void> initialize() async {
    _registerHiveAdapters();
    _box = await Hive.openBox(boxName);
  }

  void _registerHiveAdapters() {
    Hive.registerAdapter(ClothItemAdapter());
    Hive.registerAdapter(ClothItemTypeAdapter());
    Hive.registerAdapter(ClothItemAttributeAdapter());
  }

  @override
  Future<void> saveClothItem(ClothItem clothItem) async {
    if (_itemIsAlreadySaved(clothItem)) {
      await _overwriteExistingItemOfSameId(clothItem);
    } else {
      await _saveNewItem(clothItem);
    }
  }

  @override
  Future<void> saveManyClothItems(List<ClothItem> clothItems) async {
    for (var clothItem in clothItems) {
      await saveClothItem(clothItem);
    }
  }

  @override
  Future<void> deleteClothItem(ClothItem clothItem) async {
    final itemIndex = _findIndexOfItem(clothItem)!;
    await _box.deleteAt(itemIndex);
  }

  @override
  Future<void> deleteAll() async => await _box.clear();

  @override
  List<ClothItem> get savedItems => [
        for (int i = 0; i < _box.length; i++)
          if (_box.getAt(i) != null) _box.getAt(i)!
      ];

  @override
  set savedItems(List<ClothItem> items) {
    throw Exception("cannot set saved items");
  }

  Future<void> _saveNewItem(ClothItem clothItem) async {
    await _box.add(clothItem);
  }

  Future<void> _overwriteExistingItemOfSameId(ClothItem clothItem) async {
    final index = _findIndexOfItem(clothItem)!;
    await _box.putAt(index, clothItem);
  }

  bool _itemIsAlreadySaved(ClothItem clothItem) =>
      _findIndexOfItem(clothItem) != null;

  int? _findIndexOfItem(ClothItem clothItem) {
    int itemIndex = savedItems.indexWhere(clothItem.hasSameIdAs);
    return itemIndex.isNegative ? null : itemIndex;
  }
}
