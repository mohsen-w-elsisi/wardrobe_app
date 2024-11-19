import 'dart:convert';
import 'dart:typed_data';

import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class ClothItemJsonImportExportClient implements ClothItemImportExportClient {
  @override
  String export(List<ClothItem> items) {
    return _JsonItemExporter(items).export();
  }

  @override
  List<ClothItem> import(String json) {
    return _JsonItemImporter(json).import();
  }
}

class _JsonItemExporter {
  final List<ClothItem> _clothItems;

  _JsonItemExporter(this._clothItems);

  String export() {
    final itemsAsMaps = _clothItems.map(_clothItemToMap).toList();
    return jsonEncode(itemsAsMaps);
  }

  Map<String, dynamic> _clothItemToMap(ClothItem item) {
    return <String, dynamic>{
      "id": item.id,
      "name": item.name,
      "type": item.type.index,
      "attributes": [for (final attr in item.attributes) attr.index],
      "matchingItems": item.matchingItems,
      "image": item.image.toList(),
    };
  }
}

class _JsonItemImporter {
  final String _jsonText;

  _JsonItemImporter(this._jsonText);

  List<ClothItem> import() {
    final itemMaps = parseJsonTextToMaps();
    return [
      for (final itemMap in itemMaps) _ClothItemJsonDecoder(itemMap).decode()
    ];
  }

  List<Map<String, dynamic>> parseJsonTextToMaps() {
    return _castAsListOf<Map<String, dynamic>>(
      jsonDecode(_jsonText),
    );
  }
}

class _ClothItemJsonDecoder {
  final Map<String, dynamic> _itemMap;

  late final String _id;
  late final String _name;
  late final int _typeIndex;
  late final List<int> _attributeIndicies;
  late final List<String> _matchingItems;
  late final List<int> _imageByteList;

  late final ClothItem _clothItem;

  _ClothItemJsonDecoder(this._itemMap);

  ClothItem decode() {
    _extractItemPropertiesFromMap();
    _assembleClothItem();
    return _clothItem;
  }

  void _assembleClothItem() {
    _clothItem = ClothItem(
      id: _id,
      name: _name,
      type: ClothItemType.values[_typeIndex],
      isFavourite: false,
      attributes: _attributes,
      matchingItems: _matchingItems,
      dateCreated: DateTime.now(),
      image: Uint8List.fromList(_imageByteList),
    );
  }

  List<ClothItemAttribute> get _attributes {
    return [
      for (final index in _attributeIndicies) ClothItemAttribute.values[index]
    ];
  }

  void _extractItemPropertiesFromMap() {
    _id = _itemMap["id"] as String;
    _name = _itemMap["name"] as String;
    _typeIndex = _itemMap["type"] as int;
    _attributeIndicies = _castAsListOf<int>(_itemMap["attributes"]);
    _matchingItems = _castAsListOf<String>(_itemMap["matchingItems"]);
    _imageByteList = _castAsListOf<int>(_itemMap["image"]);
  }
}

List<T> _castAsListOf<T>(dynamic object) => (object as List).cast<T>();
