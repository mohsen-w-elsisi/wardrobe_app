import "package:hive/hive.dart";

part 'cloth_item.g.dart';

@HiveType(typeId: 1)
class ClothItem {
  @HiveField(1)
  late final String id;

  @HiveField(2)
  late final DateTime dateCreated;

  @HiveField(3)
  String name;

  @HiveField(4)
  ClothItemType type;

  @HiveField(5)
  bool isFavourite;

  @HiveField(6)
  List<ClothItemAttribute> attributes;

  @HiveField(7)
  List<String> matchingItems;

  ClothItem({
    required this.name,
    required this.type,
    this.isFavourite = false,
    this.attributes = const [],
    this.matchingItems = const [],
    DateTime? dateCreated,
    String? id,
  }) {
    this.dateCreated = dateCreated ?? DateTime.now();
    this.id = id ?? this.dateCreated.toIso8601String();
  }

  ClothItem.blank({
    this.name = "",
    this.type = ClothItemType.top,
    this.id = "",
    this.attributes = const [],
    this.matchingItems = const [],
    this.isFavourite = false,
  }) {
    dateCreated = DateTime.now();
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
