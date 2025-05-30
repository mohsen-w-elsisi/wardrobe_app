import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImageSelecter {
  static const _imageSize = 740.0;

  final ImageSource _source;
  late final XFile? _xFile;
  late final Uint8List _bytes;

  ImageSelecter({required ImageSource source}) : _source = source;

  Future<Uint8List?> pickImage() async {
    await _getPickedXFIle();
    if (_imageWasSelected) {
      await _readXFileAsBytes();
      return _bytes;
    } else {
      return null;
    }
  }

  Future<void> _readXFileAsBytes() async {
    _bytes = await File(_xFile!.path).readAsBytes();
  }

  Future<void> _getPickedXFIle() async {
    _xFile = await ImagePicker().pickImage(
      source: _source,
      maxWidth: _imageSize,
      maxHeight: _imageSize,
    );
  }

  bool get _imageWasSelected => _xFile != null;
}
