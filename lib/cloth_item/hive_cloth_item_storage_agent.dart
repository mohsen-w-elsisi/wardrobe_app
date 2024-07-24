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

  int? _findIndexOfItem(ClothItem clothItem) {
    final allItems = loadAllClothItems();
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
  List<ClothItem> loadAllClothItems() {
    return [
      for (int i = 0; i < _box.length; i++)
        if (_box.getAt(i) != null) _box.getAt(i)!
    ];
  }

  @override
  void saveClothItem(ClothItem clothItem) => _box.add(clothItem);

  @override
  void deleteClothItem(ClothItem clothItem) {
    final itemIndex = _findIndexOfItem(clothItem);
    assert(itemIndex != null);
    _box.deleteAt(itemIndex!);
  }

  @override
  void updateClothItem(ClothItem clothItem) {
    final itemIndex = _findIndexOfItem(clothItem);
    assert(itemIndex != null);
    _box.putAt(itemIndex!, clothItem);
  }
}
