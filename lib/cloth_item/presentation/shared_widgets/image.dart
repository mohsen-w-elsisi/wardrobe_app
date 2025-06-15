import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

class ClothItemImage extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemImage({
    super.key,
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedSquareImage(
      _itemImageProvider(),
    );
  }

  ImageProvider _itemImageProvider() => MemoryImage(clothItem.image);
}

class RoundedSquareImage extends StatelessWidget {
  final ImageProvider image;

  const RoundedSquareImage(
    this.image, {
    super.key,
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
        child: _imageWidget,
      ),
    );
  }

  Image get _imageWidget {
    return Image(
      image: image,
      fit: BoxFit.cover,
    );
  }
}
