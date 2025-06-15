import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

class ClothItemTransformer {
  final ClothItem _item;

  ClothItemTransformer(this._item);

  bool isMatchingItemOf(ClothItem testItem) =>
      _item.matchingItems.contains(testItem.id);
}
