import 'package:hive_flutter/hive_flutter.dart';

import 'cloth_item.dart';
import 'cloth_item_manager.dart';

class HiveClothItemStorageAgent extends ClothItemStorageAgent {
  static const boxName = "cloth items";

  late final Box<ClothItem> _box;

  Future<void> initialize() async {
    Hive.registerAdapter(ClothItemAdapter());
    Hive.registerAdapter(ClothItemTypeAdapter());
    Hive.registerAdapter(ClothItemAttributeAdapter());

    _box = await Hive.openBox(boxName);
  }

  @override
  List<ClothItem> get savedItems => [
        for (int i = 0; i < _box.length; i++)
          if (_box.getAt(i) != null) _box.getAt(i)!
      ];

  int? _findIndexOfItem(ClothItem clothItem) {
    final allItems = savedItems;
    int? indexOfItemToDelete;
    for (var i = 0; i < allItems.length; i++) {
      if (allItems[i].id == clothItem.id) {
        indexOfItemToDelete = i;
        break;
      }
    }
    return indexOfItemToDelete;
  }

  @override
  Future<void> saveClothItem(ClothItem clothItem) async {
    final itemIndex = _findIndexOfItem(clothItem);
    if (itemIndex == null) {
      await _box.add(clothItem);
    } else {
      await _box.putAt(itemIndex, clothItem);
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
}
