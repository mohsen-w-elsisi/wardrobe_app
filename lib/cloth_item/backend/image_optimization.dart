import 'dart:typed_data';

import 'package:wardrobe_app/cloth_item/backend/manager.dart';

// just a mock, no functionality
class ImageOptimizerImpl implements ImageOptimizer {
  final Uint8List _image;

  ImageOptimizerImpl(Uint8List imageBytes) : _image = imageBytes;

  @override
  Uint8List get optimisedImage => _image;
}
