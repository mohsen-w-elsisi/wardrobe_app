import 'package:flutter/material.dart';
import 'cloth_item.dart';

class ClothItemManager extends ChangeNotifier {
  late final List<ClothItem> _clothItems;
  final ClothItemStorageAgent storageAgent;

  ClothItemManager({required this.storageAgent}) {
    _clothItems = storageAgent.loadAllClothItems();
  }

  List<ClothItem> get clothItems => _clothItems;

  void saveNewItem(ClothItem clothItem) {
    storageAgent.saveClothItem(clothItem);
    _clothItems.add(clothItem);
    notifyListeners();
  }

  void saveManyNewItems(List<ClothItem> clothItems) {
    clothItems.forEach(storageAgent.saveClothItem);
    _clothItems.addAll(clothItems);
    notifyListeners();
  }

  ClothItem? getClothItemById(String id) {
    final matchedClothItem = _clothItems.firstWhere(
      (clothItem) => clothItem.id == id,
      orElse: () => ClothItem.blank(),
    );
    return matchedClothItem.id != "" ? matchedClothItem : null;
  }

  List<ClothItem> getMatchingItems(ClothItem clothItem) {
    return _clothItems
        .where(
          (testClothItem) => clothItem.matchingItems.contains(testClothItem.id),
        )
        .toList();
  }

  void deleteAllItems() {
    _clothItems.forEach(storageAgent.deleteClothItem);
    notifyListeners();
  }
}

abstract class ClothItemStorageAgent {
  List<ClothItem> loadAllClothItems();
  void saveClothItem(ClothItem clothItem);
  void deleteClothItem(ClothItem clothiItem);
  void updateClothItem(ClothItem clothItem);
}
