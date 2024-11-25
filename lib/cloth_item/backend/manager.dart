import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'cloth_item.dart';

class ClothItemManager extends ChangeNotifier {
  final ClothItemQuerier querier;
  final ClothItemStorageAgent storageAgent;
  final DifferCreater createDiffer;
  final ClothItemImportExportClient importExportClient;
  final ClothItemImageManager imageManager;

  ClothItemManager({
    required this.querier,
    required this.storageAgent,
    required this.createDiffer,
    required this.importExportClient,
    required this.imageManager,
  }) {
    _filterDuplicates();
  }

  List<ClothItem> get clothItems => querier.cltohItems;

  ClothItem? getClothItemById(String id) => querier.getById(id);

  String export() => importExportClient.export(clothItems);

  void import(String json) {
    final importedItems = importExportClient.import(json);
    importedItems.forEach(saveItem);
  }

  void saveItem(ClothItem clothItem) {
    querier.registerItem(clothItem);
    _reportChange();
    imageManager.saveImage(clothItem.id, clothItem.image);
    _repairMatchingItemWeb(clothItem);
  }

  void deleteItem(ClothItem clothItem) {
    querier.removeItem(clothItem);
    imageManager.deleteImage(clothItem.id);
    _reportChange();
  }

  void deleteAllItems() {
    querier.deleteAllItems();
    imageManager.deleteAllImages();
    _reportChange();
  }

  ImageProvider getImageOfItem(ClothItem item) {
    final imageBytes = imageManager.getImage(item.id);
    return MemoryImage(imageBytes);
  }

  void toggleFavouriteForItem(ClothItem clothItem) {
    final adjustedItem = clothItem.toggleFavourite();
    saveItem(adjustedItem);
  }

  List<ClothItem> getMatchingItems(ClothItem clothItem) =>
      querier.matchingItemsOf(clothItem);

  void _reportChange() {
    _filterDuplicates();
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

  void _filterDuplicates() {
    // TODO: implement _filterDuplicates
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
  bool itemIsRegistered(ClothItem item);
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

abstract class ClothItemImageManager {
  Uint8List getImage(String id);
  void saveImage(String id, Uint8List imageBytes);
  void deleteImage(String id);
  void deleteAllImages();
}
