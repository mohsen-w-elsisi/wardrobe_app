import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';

abstract class ClothItemQuerier {
  List<ClothItem> getAll();
  ClothItem getById(String id);
}

abstract class ClothItemSaver {
  void save(ClothItem item);
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

abstract class ClothItemDataGateway {
  Iterable<ClothItem> getAllItems();
  ClothItem getById(String id);
  void save(ClothItem item);
  void delete(String id);
  void deleteAll();
}
