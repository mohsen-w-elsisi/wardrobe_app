import 'dart:typed_data';

import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class ClothItemImageManagerImpl implements ClothItemImageManager {
  final ClothItemImageStorageAgent _storageAgent;

  ClothItemImageManagerImpl({
    required ClothItemImageStorageAgent storageAgent,
  }) : _storageAgent = storageAgent;

  @override
  Future<Uint8List> getImage(String id) {
    return _storageAgent.getImage(id);
  }

  @override
  void saveImage(String id, Uint8List imageBytes) {
    _storageAgent.saveImage(id, imageBytes);
  }

  @override
  void deleteImage(String id) {
    _storageAgent.deleteImage(id);
  }

  @override
  void deleteAllImages() {
    _storageAgent.deleteAllImages();
  }
}

abstract class ClothItemImageStorageAgent {
  Future<Uint8List> getImage(String id);
  void saveImage(String id, Uint8List imageBytes);
  void deleteImage(String id);
  void deleteAllImages();
  Future<List<String>> savedIDs();
}

abstract class ClothItemImageCachingAgent {
  void cacheImage(String id, Uint8List imageBytes);
  Uint8List getCachedImage(String id);
}
