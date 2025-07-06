import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

abstract class ClothItemMatcher {
  Future<List<ClothItem>> findMatchingItems(ClothItem item);
  Future<List<ClothItem>> findMatchingItemsOfSeason(ClothItem item);
}

abstract class ClothItemQuerier {
  Future<List<ClothItem>> getAll();
  Future<List<ClothItem>> getAllofCurrentSeason();
  Future<ClothItem> getById(String id);
  Future<bool> itemExists(String id);
}

abstract class ClothItemSaver {
  void save(ClothItem item);
}

abstract class ClothItemFavouriteToggler {
  void toggleItem(ClothItem item);
}

abstract class ClothItemDeleter {
  void delete(ClothItem item);
}

abstract class ClothItemImporter {
  void import(String importableText);
}

abstract class ClothItemExporter {
  Future<String> export();
}
