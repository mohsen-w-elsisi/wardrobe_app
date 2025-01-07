import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';

class ClothItemTransformer {
  final ClothItem _item;

  ClothItemTransformer(this._item);

  bool isMatchingItemOf(ClothItem testItem) =>
      _item.matchingItems.contains(testItem.id);
}
