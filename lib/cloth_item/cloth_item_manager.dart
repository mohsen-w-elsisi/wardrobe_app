import 'package:flutter/material.dart';
import 'cloth_item.dart';

class ClothItemManager extends ChangeNotifier {
  late final List<ClothItem> _clothItems;
  final ClothItemStorageAgent storageAgent;

  ClothItemManager({required this.storageAgent}) {
    _clothItems = storageAgent.loadAllClothItems();
  }

  int? _findIndexOfItem(ClothItem clothItem) {
    final index = _clothItems.indexWhere(
      (testClothItem) => testClothItem.id == clothItem.id,
    );
    return index.isNegative ? null : index;
  }

  List<ClothItem> get clothItems => _clothItems;

  void saveNewItem(ClothItem clothItem) {
    storageAgent.saveClothItem(clothItem);
    _clothItems.add(clothItem);
    updateMatchingItemsToReference(clothItem);
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

  void updateMatchingItemsToReference(ClothItem clothItem) => clothItem
      .matchingItems
      .map(getClothItemById)
      .whereType<ClothItem>()
      .where((e) => !e.matchingItems.contains(clothItem.id))
      .map((e) => e.copyWith(matchingItems: [...e.matchingItems, clothItem.id]))
      .forEach(replaceItem);

  void replaceItem(ClothItem clothItem) {
    updateMatchingItemsToReference(clothItem);
    final itemIndex = _findIndexOfItem(clothItem)!;
    _clothItems[itemIndex] = clothItem;
    storageAgent.saveClothItem(clothItem);
    notifyListeners();
  }

  void addOrReplaceItem(ClothItem clothItem) {
    if (_findIndexOfItem(clothItem) == null) {
      saveNewItem(clothItem);
    } else {
      replaceItem(clothItem);
    }
  }

  void toggleFavouriteForItem(ClothItem clothItem) {
    final newItem = clothItem.copyWith(isFavourite: !clothItem.isFavourite);
    final itemIndex = _findIndexOfItem(clothItem)!;
    storageAgent.updateClothItem(newItem);
    _clothItems[itemIndex] = newItem;
    notifyListeners();
  }

  void deleteItem(ClothItem clothItem) {
    final itemIndex = _findIndexOfItem(clothItem)!;
    storageAgent.deleteClothItem(clothItem);
    _clothItems.removeAt(itemIndex);
    notifyListeners();
  }

  void deleteAllItems() {
    [..._clothItems].forEach(deleteItem);
    notifyListeners();
  }
}

abstract class ClothItemStorageAgent {
  List<ClothItem> loadAllClothItems();
  void saveClothItem(ClothItem clothItem);
  void deleteClothItem(ClothItem clothItem);
  void updateClothItem(ClothItem clothItem);
}
