import 'dart:typed_data';

import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/shared/entities/season.dart';

class ClothItemEditingManager {
  late final DateTime dateCreated;
  final bool isFavourite;
  String? id;
  String name;
  ClothItemType type;
  List<ClothItemAttribute> attributes;
  List<String> matchingItems;
  Uint8List image;
  Season season;

  ClothItemEditingManager()
      : dateCreated = DateTime.now(),
        name = "",
        type = ClothItemType.top,
        attributes = [],
        matchingItems = [],
        isFavourite = false,
        image = Uint8List(0),
        season = Season.all;

  ClothItemEditingManager.from(ClothItem clothitem)
      : dateCreated = clothitem.dateCreated,
        id = clothitem.id,
        name = clothitem.name,
        type = clothitem.type,
        attributes = clothitem.attributes.toList(growable: true),
        matchingItems = clothitem.matchingItems.toList(growable: true),
        isFavourite = clothitem.isFavourite,
        image = clothitem.image,
        season = clothitem.season;

  ClothItem get clothItem => ClothItem(
        id: id ?? dateCreated.toIso8601String(),
        name: name,
        type: type,
        dateCreated: dateCreated,
        isFavourite: isFavourite,
        attributes: attributes,
        matchingItems: matchingItems,
        image: image,
        season: season,
      );

  bool get requiredFieldsSet => name != "" && image.isNotEmpty;
}
