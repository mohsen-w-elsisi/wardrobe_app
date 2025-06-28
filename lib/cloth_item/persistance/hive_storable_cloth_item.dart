import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

part 'hive_storable_cloth_item.g.dart';

@HiveType(typeId: 6)
class HiveStorableClothItem {
  @HiveField(1)
  final String id;

  @HiveField(2)
  final DateTime dateCreated;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final int type;

  @HiveField(5)
  final bool isFavourite;

  @HiveField(6)
  final List<int> attributes;

  @HiveField(7)
  final List<String> matchingItems;

  @HiveField(8)
  final Uint8List image;

  @HiveField(9)
  final int season;

  HiveStorableClothItem({
    required this.id,
    required this.name,
    required this.image,
    required this.dateCreated,
    required this.type,
    required this.attributes,
    required this.isFavourite,
    required this.matchingItems,
    required this.season,
  });

  HiveStorableClothItem.fromClothItem(ClothItem item)
      : this(
          id: item.id,
          name: item.name,
          dateCreated: item.dateCreated,
          image: item.image,
          type: item.type.index,
          attributes: [for (final attr in item.attributes) attr.index],
          isFavourite: item.isFavourite,
          matchingItems: item.matchingItems,
          season: item.season.index,
        );

  ClothItem toClothItem() => ClothItem(
        id: id,
        name: name,
        image: image,
        dateCreated: dateCreated,
        type: ClothItemType.values[type],
        attributes: [
          for (final index in attributes) ClothItemAttribute.values[index]
        ],
        isFavourite: isFavourite,
        matchingItems: matchingItems,
        season: Season.values[season],
      );
}
