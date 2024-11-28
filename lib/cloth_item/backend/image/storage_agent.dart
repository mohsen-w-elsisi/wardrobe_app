import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/backend/image/manager.dart';

import '../manager.dart';

class ClothItemImageSqliteStorageAgent implements ClothItemImageStorageAgent {
  final Map<String, Uint8List> _savedImages = {};

  @override
  Uint8List getImage(String id) {
    return _savedImages[id] ??
        GetIt.I.get<ClothItemManager>().getClothItemById(id)!.image;
  }

  @override
  void saveImage(String id, Uint8List imageBytes) {
    _savedImages[id] = imageBytes;
  }

  @override
  void deleteImage(String id) {
    _savedImages.remove(id);
  }

  @override
  void deleteAllImages() {
    _savedImages.clear();
  }

  @override
  // TODO: implement savedIDs
  List<String> get savedIDs => throw UnimplementedError();
}
