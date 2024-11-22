import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class ClothItemImageManagerImpl implements ClothItemImageManager {
  // final ClothItemImageStorageAgent _storageAgent;
  // final ClothItemImageCachingAgent _cachingAgent;

  // ClothItemImageManagerImpl({
  //   required ClothItemImageStorageAgent storageAgent,
  //   required ClothItemImageCachingAgent cachingAgent,
  // }) : _cachingAgent = cachingAgent, _storageAgent = storageAgent;

  // Future<void> initialise() async {}

  @override
  Uint8List getImage(String id) {
    final itemManager = GetIt.I.get<ClothItemManager>();
    return itemManager.getClothItemById(id)!.image;
  }

  @override
  void saveImage(String id, Uint8List imageBytes) {
    // TODO: implement saveImage
  }

  @override
  void deleteImage(String id) {
    // TODO: implement deleteImage
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
