import 'dart:convert';

import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/use_case_utils.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

class ClothItemJsonExporter extends ClothItemExporter with UseCaseUtils {
  @override
  String export() {
    var items = dataGateway.getAllItems().toList();
    return _JsonItemExporter(items).export();
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
