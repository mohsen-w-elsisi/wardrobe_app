import 'package:flutter/material.dart';
import 'cloth_item.dart';

class ClothItemManager extends ChangeNotifier {
  late List<ClothItem> _clothItems;
  final ClothItemStorageAgent storageAgent;

  ClothItemManager({required this.storageAgent}) {
    _clothItems = storageAgent.savedItems;
    _filterDuplicates();
  }

  List<ClothItem> get clothItems => _clothItems;

  void saveItem(ClothItem clothItem) {
    if (_itemIsAlreadySaved(clothItem)) {
      _overwriteExistingItemOfSameId(clothItem);
    } else {
      _saveNewItem(clothItem);
    }
    _repairMatchingItemWeb(clothItem);
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

  void toggleFavouriteForItem(ClothItem clothItem) {
    final adjustedItem = clothItem.toggleFavourite();
    saveItem(adjustedItem);
  }

  List<ClothItem> getMatchingItems(ClothItem clothItem) {
    return _clothItems.where(clothItem.isMatchingItem).toList();
  }

  void _saveNewItem(ClothItem clothItem) {
    _clothItems.add(clothItem);
    _reportChange();
  }

  void _overwriteExistingItemOfSameId(ClothItem clothItem) {
    final itemIndex = _findIndexOfItem(clothItem)!;
    _clothItems[itemIndex] = clothItem;
    _reportChange();
  }

  void _reportChange() {
    _filterDuplicates();
    _updateStorage();
    notifyListeners();
  }

  void _updateStorage() async {
    await storageAgent.deleteAll();
    await storageAgent.saveManyClothItems(_clothItems);
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

  void _repairMatchingItemWeb(ClothItem clothItem) => clothItem.matchingItems
      .map(getClothItemById)
      .nonNulls
      .where((e) => !e.isMatchingItem(clothItem))
      .map((e) => e.addMatchingItem(clothItem))
      .forEach(saveItem);

  bool _itemIsAlreadySaved(ClothItem clothItem) =>
      _findIndexOfItem(clothItem) != null;

  int? _findIndexOfItem(ClothItem clothItem) {
    final index = _clothItems.indexWhere(clothItem.hasSameIdAs);
    return index.isNegative ? null : index;
  }

  ClothItem? getClothItemById(String id) {
    final matchedClothItem = _clothItems.firstWhere(
      (clothItem) => clothItem.id == id,
      orElse: () => ClothItem.blank(),
    );
    return matchedClothItem.isBlank ? null : matchedClothItem;
  }
}

abstract class ClothItemStorageAgent {
  late List<ClothItem> savedItems;
  Future<void>? saveClothItem(ClothItem clothItem);
  Future<void>? saveManyClothItems(List<ClothItem> clothItems);
  Future<void>? deleteClothItem(ClothItem clothItem);
  Future<void>? deleteAll();
}
