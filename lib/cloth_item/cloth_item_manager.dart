import 'package:flutter/material.dart';
import 'cloth_item.dart';

class ClothItemManager extends ChangeNotifier {
  late List<ClothItem> _clothItems;
  final ClothItemStorageAgent storageAgent;

  ClothItemManager({required this.storageAgent}) {
    _clothItems = storageAgent.savedItems;
    _filterDuplicates();
  }

  void _reportChange() {
    _filterDuplicates();
    _updateStorage();
    notifyListeners();
  }

  void _filterDuplicates() {
    final clothItemIds = <String>[];
    for (final item in _clothItems) {
      if (!clothItemIds.contains(item.id)) {
        clothItemIds.add(item.id);
      }
    }
    _clothItems = clothItemIds.map(getClothItemById).nonNulls.toList();
  }

  void _updateStorage() async {
    await storageAgent.deleteAll();
    await storageAgent.saveManyClothItems(_clothItems);
  }

  void _repairMatchingItemWeb(ClothItem clothItem) => clothItem.matchingItems
      .map(getClothItemById)
      .nonNulls
      .where((e) => !e.matchingItems.contains(clothItem.id))
      .map((e) => e.copyWith(matchingItems: [...e.matchingItems, clothItem.id]))
      .forEach(saveItem);

  int? _findIndexOfItem(ClothItem clothItem) {
    final index = _clothItems.indexWhere(
      (testClothItem) => testClothItem.id == clothItem.id,
    );
    return index.isNegative ? null : index;
  }

  List<ClothItem> get clothItems => _clothItems;

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

  void saveItem(ClothItem clothItem) {
    final itemIndex = _findIndexOfItem(clothItem);
    if (itemIndex == null) {
      _clothItems.add(clothItem);
    } else {
      _clothItems[itemIndex] = clothItem;
    }
    _repairMatchingItemWeb(clothItem);
    _reportChange();
  }

  void toggleFavouriteForItem(ClothItem clothItem) {
    final newItem = clothItem.copyWith(isFavourite: !clothItem.isFavourite);
    saveItem(newItem);
  }

  void deleteItem(ClothItem clothItem) {
    final itemIndex = _findIndexOfItem(clothItem)!;
    _clothItems.removeAt(itemIndex);
    _reportChange();
  }

  void deleteAllItems() {
    _clothItems = [];
    _reportChange();
  }
}

abstract class ClothItemStorageAgent {
  late List<ClothItem> savedItems;
  Future<void>? saveClothItem(ClothItem clothItem);
  Future<void>? saveManyClothItems(List<ClothItem> clothItems);
  Future<void>? deleteClothItem(ClothItem clothItem);
  Future<void>? deleteAll();
}
