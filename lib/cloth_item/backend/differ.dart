import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class MockClothItemDiffer implements ClothItemDiffer {
  @override
  List<ClothItem> diff({
    required List<ClothItem> storedItems,
    required List<ClothItem> currentItems,
  }) {
    print("something was diffed");
    return currentItems;
  }
}
