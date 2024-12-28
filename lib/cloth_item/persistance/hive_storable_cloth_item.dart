import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';

part 'hive_storable_cloth_item.g.dart';

@HiveType(typeId: 6)
class HiveStorableClothItem implements ClothItem {
  late final ClothItem _parent;

  @HiveField(1)
  final String _id;

  @HiveField(2)
  final DateTime _dateCreated;

  @HiveField(3)
  final String _name;

  @HiveField(4)
  final int _type;

  @HiveField(5)
  final bool _isFavourite;

  @HiveField(6)
  final List<int> _attributes;

  @HiveField(7)
  final List<String> _matchingItems;

  @HiveField(8)
  final Uint8List _image;

  HiveStorableClothItem(this._id, this._name, this._type, this._isFavourite,
      this._attributes, this._matchingItems, this._dateCreated, this._image) {
    _parent = ClothItem(
      id: _id,
      name: _name,
      type: ClothItemType.values[_type],
      isFavourite: _isFavourite,
      attributes: _attributes.map((a) => ClothItemAttribute.values[a]).toList(),
      matchingItems: _matchingItems,
      dateCreated: _dateCreated,
      image: _image,
    );
  }

  @override
  $ClothItemCopyWith<ClothItem> get copyWith => _parent.copyWith;

  @override
  List<ClothItemAttribute> get attributes => _parent.attributes;

  @override
  DateTime get dateCreated => _parent.dateCreated;

  @override
  String get id => _parent.id;

  @override
  Uint8List get image => _parent.image;

  @override
  bool get isFavourite => _parent.isFavourite;

  @override
  List<String> get matchingItems => _parent.matchingItems;

  @override
  String get name => _parent.name;

  @override
  ClothItemType get type => _parent.type;
}
