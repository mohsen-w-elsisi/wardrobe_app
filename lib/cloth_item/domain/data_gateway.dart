import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

abstract class ClothItemDataGateway {
  Future<Iterable<ClothItem>> getAllItems();
  Future<ClothItem> getById(String id);
  Future<void> save(ClothItem item);
  Future<void> delete(String id);
  Future<void> deleteAll();
}
