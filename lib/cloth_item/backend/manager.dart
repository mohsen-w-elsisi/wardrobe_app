import 'package:flutter/material.dart';
import 'cloth_item.dart';

class ClothItemManager extends ChangeNotifier {
  late List<ClothItem> _clothItems;
  final ClothItemStorageAgent storageAgent;
  final ClothItemDiffer itemDiffer;
  final ClothItemImporter importer;
  final ClothItemExporter exporter;

  ClothItemManager({
    required this.storageAgent,
    required this.itemDiffer,
    required this.importer,
    required this.exporter,
  }) {
    _clothItems = storageAgent.savedItems;
    _filterDuplicates();
  }

  void import(String json) {
    final importedItems = importer.import(json);
    importedItems.forEach(saveItem);
  }

  String export() {
    return exporter.export(clothItems);
  }

  List<ClothItem> get clothItems => List.unmodifiable(_clothItems);

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
    final changedItems = itemDiffer.diff(
      storedItems: storageAgent.savedItems,
      currentItems: clothItems,
    );
    await storageAgent.deleteManyClothItems(changedItems)
    await storageAgent.saveManyClothItems(changedItems);
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
  Future<void>? deleteManyClothItems(List<ClothItem> clothItems);
  Future<void>? deleteAll();
}

abstract class ClothItemDiffer {
  List<ClothItem> diff({
    required List<ClothItem> storedItems,
    required List<ClothItem> currentItems,
  });
}

abstract class ClothItemExporter {
  String export(List<ClothItem> items);
}

abstract class ClothItemImporter {
  List<ClothItem> import(String json);
}
