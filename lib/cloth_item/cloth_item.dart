import "package:collection/collection.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:hive/hive.dart";

part 'cloth_item.g.dart';

@HiveType(typeId: 1)
@immutable
class ClothItem {
  @HiveField(1)
  late final String id;

  @HiveField(2)
  late final DateTime dateCreated;

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
  }) : dateCreated = DateTime.now();

  ClothItem copyWith({
    final String? name,
    final ClothItemType? type,
    final String? id,
    final List<ClothItemAttribute>? attributes,
    final List<String>? matchingItems,
    final bool? isFavourite,
    final DateTime? dateCreated,
  }) =>
      ClothItem(
        name: name ?? this.name,
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
        matchingItems: matchingItems ?? this.matchingItems,
        isFavourite: isFavourite ?? this.isFavourite,
        dateCreated: dateCreated ?? this.dateCreated,
      );

  bool isIdenticalTo(ClothItem clothItem) {
    return (clothItem.id == id &&
        clothItem.isFavourite == isFavourite &&
        clothItem.name == name &&
        clothItem.dateCreated.toString() == dateCreated.toString() &&
        clothItem.type == type &&
        const IterableEquality().equals(
          clothItem.attributes as Iterable,
          attributes as Iterable,
        ) &&
        const IterableEquality().equals(
          clothItem.matchingItems as Iterable,
          matchingItems as Iterable,
        ));
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
