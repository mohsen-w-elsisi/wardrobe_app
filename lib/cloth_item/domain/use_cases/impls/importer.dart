import 'dart:convert';
import 'dart:typed_data';

import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/use_case_utils.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

class ClothItemJsonImporter extends ClothItemImporter with UseCaseUtils {
  @override
  void import(String importableText) {
    final importedItems = _JsonItemParser(importableText).parse();
    importedItems.forEach(dataGateway.save);
    notifyUi();
  }
}

class _JsonItemParser {
  final String _jsonText;

  _JsonItemParser(this._jsonText);

  List<ClothItem> parse() {
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

  void _extractItemPropertiesFromMap() {
    _id = _itemMap["id"] as String;
    _name = _itemMap["name"] as String;
    _typeIndex = _itemMap["type"] as int;
    _attributeIndicies = _castAsListOf<int>(_itemMap["attributes"]);
    _matchingItems = _castAsListOf<String>(_itemMap["matchingItems"]);
    _imageByteList = _castAsListOf<int>(_itemMap["image"]);
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
}

List<T> _castAsListOf<T>(dynamic object) => (object as List).cast<T>();
