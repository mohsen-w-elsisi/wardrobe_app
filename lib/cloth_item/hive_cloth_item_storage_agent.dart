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
  List<ClothItem> loadAllClothItems() {
    return [
      for (int i = 0; i < _box.length; i++)
        if (_box.getAt(i) != null) _box.getAt(i)!
    ];
  }

  @override
  void saveClothItem(ClothItem clothItem) => _box.add(clothItem);

  @override
  void deleteClothItem(ClothItem clothiItem) {
    // TODO: implement deleteClothItem
    throw UnimplementedError();
  }

  @override
  void updateClothItem(ClothItem clothItem) {
    // TODO: implement updateClothItem
    throw UnimplementedError();
  }
}
