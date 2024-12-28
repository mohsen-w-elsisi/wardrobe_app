import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_structures.freezed.dart';

@Freezed()
class ClothItem with _$ClothItem {
  const factory ClothItem({
    required String id,
    required String name,
    required ClothItemType type,
    required bool isFavourite,
    required List<ClothItemAttribute> attributes,
    required List<String> matchingItems,
    required DateTime dateCreated,
    required Uint8List image,
  }) = _ClothItem;
}

enum ClothItemType { headWear, top, bottom, jacket, shoe }

enum ClothItemAttribute { sportive, onFasion, classic }
