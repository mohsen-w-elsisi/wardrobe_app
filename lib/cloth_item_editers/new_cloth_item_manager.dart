import 'package:wardrobe_app/cloth_item/cloth_item.dart';

class NewClothItemManager {
  late final DateTime dateCreated;
  final isFavourite = false;
  String name = "";
  ClothItemType type = ClothItemType.top;
  List<ClothItemAttribute> attributes = [];
  List<String> matchingItems = [];

  NewClothItemManager() : dateCreated = DateTime.now();

  ClothItem get clothItem => ClothItem(
        dateCreated: dateCreated,
        isFavourite: isFavourite,
        name: name,
        type: type,
        attributes: attributes,
        matchingItems: matchingItems,
      );
}
