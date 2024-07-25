import 'package:wardrobe_app/cloth_item/cloth_item.dart';

class NewClothItemManager {
  late final DateTime dateCreated;
  final bool isFavourite;
  String? id;
  String name;
  ClothItemType type;
  List<ClothItemAttribute> attributes;
  List<String> matchingItems;

  NewClothItemManager()
      : dateCreated = DateTime.now(),
        name = "",
        type = ClothItemType.top,
        attributes = [],
        matchingItems = [],
        isFavourite = false;

  NewClothItemManager.from(ClothItem clothitem)
      : dateCreated = clothitem.dateCreated,
        id = clothitem.id,
        name = clothitem.name,
        type = clothitem.type,
        attributes = clothitem.attributes,
        matchingItems = clothitem.matchingItems,
        isFavourite = clothitem.isFavourite;

  ClothItem get clothItem => ClothItem(
        id: id,
        name: name,
        type: type,
        dateCreated: dateCreated,
        isFavourite: isFavourite,
        attributes: attributes,
        matchingItems: matchingItems,
      );
}
