import 'package:flutter/material.dart';
import 'cloth_item.dart';

class ClothItemManager extends ChangeNotifier {
  final ClothItemQuerier querier;
  final ClothItemStorageAgent storageAgent;
  final DifferCreater createDiffer;
  final ClothItemImportExportClient importExportClient;

  ClothItemManager({
    required this.querier,
    required this.storageAgent,
    required this.createDiffer,
    required this.importExportClient,
  });

  List<ClothItem> get clothItems => querier.cltohItems;

  ClothItem? getClothItemById(String id) => querier.getById(id);

  String export() => importExportClient.export(clothItems);

  void import(String json) {
    final importedItems = importExportClient.import(json);
    importedItems.forEach(saveItem);
  }

  void toggleFavouriteForItem(ClothItem item) {
    final adjustedItem = item.toggleFavourite();
    saveItem(adjustedItem);
  }

  List<ClothItem> getMatchingItems(ClothItem item) =>
      querier.matchingItemsOf(item);

  void saveItem(ClothItem item) {
    querier.registerItem(item);
    _repairMatchingItemWeb(item);
    _reportChange();
  }

  void deleteItem(ClothItem item) {
    querier.removeItem(item);
    _repairMatchingItemWeb(item);
    _reportChange();
  }

  void deleteAllItems() {
    querier.deleteAllItems();
    _reportChange();
  }

  void _reportChange() {
    _updateStorageAgent();
    notifyListeners();
  }

  void _updateStorageAgent() async {
    final differ = createDiffer(
      storedItems: storageAgent.savedItems,
      currentItems: clothItems,
    );

    await storageAgent.deleteManyClothItems(differ.deletedItems);
    await storageAgent.saveManyClothItems(differ.editedItems);
    await storageAgent.saveManyClothItems(differ.newItems);
  }

  void _repairMatchingItemWeb(ClothItem clothItem) => clothItem.matchingItems
      .map(getClothItemById)
      .nonNulls
      .where((e) => !e.isMatchingItem(clothItem))
      .map((e) => e.addMatchingItem(clothItem))
      .forEach(saveItem);
}

abstract class ClothItemQuerier {
  List<ClothItem> get cltohItems;
  ClothItem? getById(String id);
  List<ClothItem> matchingItemsOf(ClothItem item);
  void registerItem(ClothItem item);
  void removeItem(ClothItem item);
  void deleteAllItems();
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
  ClothItemDiffer({
    required List<ClothItem> storedItems,
    required List<ClothItem> currentItems,
  });

  List<ClothItem> get editedItems;
  List<ClothItem> get newItems;
  List<ClothItem> get deletedItems;
}

typedef DifferCreater = ClothItemDiffer Function({
  required List<ClothItem> storedItems,
  required List<ClothItem> currentItems,
});

abstract class ClothItemImportExportClient {
  List<ClothItem> import(String json);
  String export(List<ClothItem> items);
}
