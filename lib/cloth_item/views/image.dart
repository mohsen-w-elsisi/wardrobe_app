import 'dart:typed_data';

import 'package:flutter/material.dart';

class ClothItemImage extends StatelessWidget {
  final Uint8List image;

  const ClothItemImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: _image(),
      ),
    );
  }

  Widget _image() {
    return Image.memory(
      image,
      fit: BoxFit.cover,
    );
  }
}
