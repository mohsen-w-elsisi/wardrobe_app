import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

abstract class ClothItemDataGateway {
  Iterable<ClothItem> getAllItems();
  ClothItem getById(String id);
  void save(ClothItem item);
  void delete(String id);
  void deleteAll();
}
