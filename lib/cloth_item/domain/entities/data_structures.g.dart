// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_structures.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClothItemCWProxy {
  ClothItem id(String id);

  ClothItem name(String name);

  ClothItem type(ClothItemType type);

  ClothItem isFavourite(bool isFavourite);

  ClothItem attributes(List<ClothItemAttribute> attributes);

  ClothItem matchingItems(List<String> matchingItems);

  ClothItem dateCreated(DateTime dateCreated);

  ClothItem image(Uint8List image);

  ClothItem season(Season season);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClothItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClothItem(...).copyWith(id: 12, name: "My name")
  /// ````
  ClothItem call({
    String id,
    String name,
    ClothItemType type,
    bool isFavourite,
    List<ClothItemAttribute> attributes,
    List<String> matchingItems,
    DateTime dateCreated,
    Uint8List image,
    Season season,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClothItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClothItem.copyWith.fieldName(...)`
class _$ClothItemCWProxyImpl implements _$ClothItemCWProxy {
  const _$ClothItemCWProxyImpl(this._value);

  final ClothItem _value;

  @override
  ClothItem id(String id) => this(id: id);

  @override
  ClothItem name(String name) => this(name: name);

  @override
  ClothItem type(ClothItemType type) => this(type: type);

  @override
  ClothItem isFavourite(bool isFavourite) => this(isFavourite: isFavourite);

  @override
  ClothItem attributes(List<ClothItemAttribute> attributes) =>
      this(attributes: attributes);

  @override
  ClothItem matchingItems(List<String> matchingItems) =>
      this(matchingItems: matchingItems);

  @override
  ClothItem dateCreated(DateTime dateCreated) => this(dateCreated: dateCreated);

  @override
  ClothItem image(Uint8List image) => this(image: image);

  @override
  ClothItem season(Season season) => this(season: season);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClothItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClothItem(...).copyWith(id: 12, name: "My name")
  /// ````
  ClothItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? isFavourite = const $CopyWithPlaceholder(),
    Object? attributes = const $CopyWithPlaceholder(),
    Object? matchingItems = const $CopyWithPlaceholder(),
    Object? dateCreated = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? season = const $CopyWithPlaceholder(),
  }) {
    return ClothItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ClothItemType,
      isFavourite: isFavourite == const $CopyWithPlaceholder()
          ? _value.isFavourite
          // ignore: cast_nullable_to_non_nullable
          : isFavourite as bool,
      attributes: attributes == const $CopyWithPlaceholder()
          ? _value.attributes
          // ignore: cast_nullable_to_non_nullable
          : attributes as List<ClothItemAttribute>,
      matchingItems: matchingItems == const $CopyWithPlaceholder()
          ? _value.matchingItems
          // ignore: cast_nullable_to_non_nullable
          : matchingItems as List<String>,
      dateCreated: dateCreated == const $CopyWithPlaceholder()
          ? _value.dateCreated
          // ignore: cast_nullable_to_non_nullable
          : dateCreated as DateTime,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as Uint8List,
      season: season == const $CopyWithPlaceholder()
          ? _value.season
          // ignore: cast_nullable_to_non_nullable
          : season as Season,
    );
  }
}

extension $ClothItemCopyWith on ClothItem {
  /// Returns a callable class that can be used as follows: `instanceOfClothItem.copyWith(...)` or like so:`instanceOfClothItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClothItemCWProxy get copyWith => _$ClothItemCWProxyImpl(this);
}
