import 'package:flutter/foundation.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class MockClothItemImporter implements ClothItemImporter {
  @override
  List<ClothItem> import(String json) {
    if (kDebugMode) {
      print("$json imported");
    }
    return [];
  }
}

class MockClothItemExporter implements ClothItemExporter {
  @override
  String export(List<ClothItem> items) {
    return " ";
  }
}
