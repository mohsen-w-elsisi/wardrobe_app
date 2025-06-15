import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

abstract class ClothItemMatcher {
  List<ClothItem> findMatchingItems(ClothItem item);
}

abstract class ClothItemQuerier {
  List<ClothItem> getAll();
  ClothItem getById(String id);
  bool itemExists(String id);
}

abstract class ClothItemSaver {
  void save(ClothItem item);
}

abstract class ClothItemFavouriteToggler {
  void toggleItem(ClothItem item);
}

abstract class ClothItemDeleter {
  void delete(ClothItem item);
  void clearWardrobe();
}

abstract class ClothItemImporter {
  void import(String importableText);
}

abstract class ClothItemExporter {
  String export();
}
