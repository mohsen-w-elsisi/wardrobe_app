import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class ClothItemImageManagerImpl implements ClothItemImageManager {
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
}

abstract class ClothItemImageStorageAgent {
  Uint8List getImage(String id);
  void saveImage(String id, Uint8List imageBytes);
  void deleteImage(String id);
  List<String> get savedIDs;
}

abstract class ClothItemImageCachingAgent {
  void cacheImage(String id, Uint8List imageBytes);
  Uint8List getCachedImage(String id);
}
