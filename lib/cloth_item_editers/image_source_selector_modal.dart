import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';

class ImageSelectorModal extends StatelessWidget {
  final NewClothItemManager newClothItemManager;
  final Function()? onSelect;

  const ImageSelectorModal({
    required this.newClothItemManager,
    this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final source in ImageSource.values)
          ListTile(
            onTap: () => _onSourceSelect(context, source),
            title: Text(source.name),
          )
      ],
    );
  }

  Future<void> _onSourceSelect(BuildContext context, ImageSource source) async {
    Navigator.pop(context);
    await _savedPickedImage(source);
    if (onSelect != null) onSelect!();
  }

  Future<void> _savedPickedImage(ImageSource source) async {
    final imageBytes = await ImageSelecter(source: source).pickImage();
    if (imageBytes != null) {
      newClothItemManager.image = imageBytes;
    }
  }
}

class ImageSelecter {
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
    _xFile = await ImagePicker().pickImage(source: _source);
  }

  bool get _imageWasSelected => _xFile != null;
}
