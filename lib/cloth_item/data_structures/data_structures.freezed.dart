// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_structures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClothItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ClothItemType get type => throw _privateConstructorUsedError;
  bool get isFavourite => throw _privateConstructorUsedError;
  List<ClothItemAttribute> get attributes => throw _privateConstructorUsedError;
  List<String> get matchingItems => throw _privateConstructorUsedError;
  DateTime get dateCreated => throw _privateConstructorUsedError;
  Uint8List get image => throw _privateConstructorUsedError;

  /// Create a copy of ClothItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClothItemCopyWith<ClothItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClothItemCopyWith<$Res> {
  factory $ClothItemCopyWith(ClothItem value, $Res Function(ClothItem) then) =
      _$ClothItemCopyWithImpl<$Res, ClothItem>;
  @useResult
  $Res call(
      {String id,
      String name,
      ClothItemType type,
      bool isFavourite,
      List<ClothItemAttribute> attributes,
      List<String> matchingItems,
      DateTime dateCreated,
      Uint8List image});
}

/// @nodoc
class _$ClothItemCopyWithImpl<$Res, $Val extends ClothItem>
    implements $ClothItemCopyWith<$Res> {
  _$ClothItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClothItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? isFavourite = null,
    Object? attributes = null,
    Object? matchingItems = null,
    Object? dateCreated = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ClothItemType,
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<ClothItemAttribute>,
      matchingItems: null == matchingItems
          ? _value.matchingItems
          : matchingItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClothItemImplCopyWith<$Res>
    implements $ClothItemCopyWith<$Res> {
  factory _$$ClothItemImplCopyWith(
          _$ClothItemImpl value, $Res Function(_$ClothItemImpl) then) =
      __$$ClothItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ClothItemType type,
      bool isFavourite,
      List<ClothItemAttribute> attributes,
      List<String> matchingItems,
      DateTime dateCreated,
      Uint8List image});
}

/// @nodoc
class __$$ClothItemImplCopyWithImpl<$Res>
    extends _$ClothItemCopyWithImpl<$Res, _$ClothItemImpl>
    implements _$$ClothItemImplCopyWith<$Res> {
  __$$ClothItemImplCopyWithImpl(
      _$ClothItemImpl _value, $Res Function(_$ClothItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClothItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? isFavourite = null,
    Object? attributes = null,
    Object? matchingItems = null,
    Object? dateCreated = null,
    Object? image = null,
  }) {
    return _then(_$ClothItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ClothItemType,
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<ClothItemAttribute>,
      matchingItems: null == matchingItems
          ? _value._matchingItems
          : matchingItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$ClothItemImpl implements _ClothItem {
  const _$ClothItemImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.isFavourite,
      required final List<ClothItemAttribute> attributes,
      required final List<String> matchingItems,
      required this.dateCreated,
      required this.image})
      : _attributes = attributes,
        _matchingItems = matchingItems;

  @override
  final String id;
  @override
  final String name;
  @override
  final ClothItemType type;
  @override
  final bool isFavourite;
  final List<ClothItemAttribute> _attributes;
  @override
  List<ClothItemAttribute> get attributes {
    if (_attributes is EqualUnmodifiableListView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attributes);
  }

  final List<String> _matchingItems;
  @override
  List<String> get matchingItems {
    if (_matchingItems is EqualUnmodifiableListView) return _matchingItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matchingItems);
  }

  @override
  final DateTime dateCreated;
  @override
  final Uint8List image;

  @override
  String toString() {
    return 'ClothItem(id: $id, name: $name, type: $type, isFavourite: $isFavourite, attributes: $attributes, matchingItems: $matchingItems, dateCreated: $dateCreated, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClothItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isFavourite, isFavourite) ||
                other.isFavourite == isFavourite) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            const DeepCollectionEquality()
                .equals(other._matchingItems, _matchingItems) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated) &&
            const DeepCollectionEquality().equals(other.image, image));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      isFavourite,
      const DeepCollectionEquality().hash(_attributes),
      const DeepCollectionEquality().hash(_matchingItems),
      dateCreated,
      const DeepCollectionEquality().hash(image));

  /// Create a copy of ClothItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClothItemImplCopyWith<_$ClothItemImpl> get copyWith =>
      __$$ClothItemImplCopyWithImpl<_$ClothItemImpl>(this, _$identity);
}

abstract class _ClothItem implements ClothItem {
  const factory _ClothItem(
      {required final String id,
      required final String name,
      required final ClothItemType type,
      required final bool isFavourite,
      required final List<ClothItemAttribute> attributes,
      required final List<String> matchingItems,
      required final DateTime dateCreated,
      required final Uint8List image}) = _$ClothItemImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  ClothItemType get type;
  @override
  bool get isFavourite;
  @override
  List<ClothItemAttribute> get attributes;
  @override
  List<String> get matchingItems;
  @override
  DateTime get dateCreated;
  @override
  Uint8List get image;

  /// Create a copy of ClothItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClothItemImplCopyWith<_$ClothItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
