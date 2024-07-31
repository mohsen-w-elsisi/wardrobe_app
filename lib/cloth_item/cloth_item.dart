import "package:flutter/foundation.dart";
import "package:hive/hive.dart";

part 'cloth_item.g.dart';

@HiveType(typeId: 1)
@immutable
class ClothItem {
  @HiveField(1)
  final String id;

  @HiveField(2)
  final DateTime dateCreated;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final ClothItemType type;

  @HiveField(5)
  final bool isFavourite;

  @HiveField(6)
  final List<ClothItemAttribute> attributes;

  @HiveField(7)
  final List<String> matchingItems;

  @HiveField(8)
  final Uint8List image;

  const ClothItem({
    required this.name,
    required this.type,
    required this.isFavourite,
    required this.attributes,
    required this.matchingItems,
    required this.dateCreated,
    required this.id,
    required this.image,
  });

  ClothItem.blank({
    this.name = "",
    this.type = ClothItemType.top,
    this.id = "",
    this.attributes = const [],
    this.matchingItems = const [],
    this.isFavourite = false,
  })  : dateCreated = DateTime.now(),
        image = Uint8List(0);

  ClothItem copyWith({
    final String? name,
    final ClothItemType? type,
    final String? id,
    final List<ClothItemAttribute>? attributes,
    final List<String>? matchingItems,
    final bool? isFavourite,
    final DateTime? dateCreated,
    final Uint8List? image,
  }) {
    return ClothItem(
      name: name ?? this.name,
      type: type ?? this.type,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      matchingItems: matchingItems ?? this.matchingItems,
      isFavourite: isFavourite ?? this.isFavourite,
      dateCreated: dateCreated ?? this.dateCreated,
      image: image ?? this.image,
    );
  }

  bool get isBlank => id == "";

  bool isMatchingItem(ClothItem clothItem) =>
      matchingItems.contains(clothItem.id);

  bool hasSameIdAs(ClothItem clothItem) => clothItem.id == id;

  ClothItem toggleFavourite() => copyWith(isFavourite: !isFavourite);

  ClothItem addMatchingItem(ClothItem newMatchingItem) {
    return copyWith(
      matchingItems: [...matchingItems, newMatchingItem.id],
    );
  }
}

@HiveType(typeId: 2)
enum ClothItemType {
  @HiveField(0)
  top,
  @HiveField(1)
  bottom,
  @HiveField(2)
  jacket
}

@HiveType(typeId: 3)
enum ClothItemAttribute {
  @HiveField(0)
  sportive,
  @HiveField(1)
  onFasion,
  @HiveField(2)
  classic
}
