import 'cloth_item.dart';

class ClothItemOrganiser {
  final List<ClothItem> clothItems;

  const ClothItemOrganiser(this.clothItems);

  List<ClothItem> get tops => filterClothItemBytype(ClothItemType.top);
  List<ClothItem> get bottoms => filterClothItemBytype(ClothItemType.bottom);
  List<ClothItem> get jackets => filterClothItemBytype(ClothItemType.jacket);

  List<ClothItem> filterClothItemBytype(ClothItemType type) {
    return [
      for (final item in clothItems)
        if (item.type == type) item
    ];
  }
}
