import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';

part 'data_structures.g.dart';

@CopyWith()
class ClothItem {
  final String id;
  final String name;
  final ClothItemType type;
  final bool isFavourite;
  final List<ClothItemAttribute> attributes;
  final List<String> matchingItems;
  final DateTime dateCreated;
  final Uint8List image;
  final Season season;

  ClothItem({
    required this.id,
    required this.name,
    required this.type,
    required this.isFavourite,
    required this.attributes,
    required this.matchingItems,
    required this.dateCreated,
    required this.image,
    required this.season,
  });
}

enum ClothItemType { headWear, top, bottom, jacket, shoe }

enum ClothItemAttribute { sportive, onFasion, classic }

enum Season { summer, winter, all }
