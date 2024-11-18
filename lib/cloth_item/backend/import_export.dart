import 'dart:convert';

import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class ClothItemJsonImportExportClient implements ClothItemImportExportClient {
  @override
  String export(List<ClothItem> items) {
    return _JsonItemExporter(items).export();
  }

  @override
  List<ClothItem> import(String json) {
    // TODO: implement import
    throw UnimplementedError();
  }
}

class _JsonItemImporter {}

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
      "image": item.image.toString(),
    };
  }
}
