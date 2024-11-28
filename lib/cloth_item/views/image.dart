import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class ClothItemImage extends StatelessWidget {
  static final _emptyImage = MemoryImage(
    const Base64Codec().decode(
      "R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7",
    ),
  );

  final ClothItem clothItem;

  const ClothItemImage({
    super.key,
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _itemImageProvider(),
      initialData: _emptyImage,
      builder: (_, AsyncSnapshot snapshot) {
        return RoundedSquareImage(
          snapshot.data,
        );
      },
    );
  }

  Future<ImageProvider> _itemImageProvider() =>
      _clothItemManager.getImageOfItem(clothItem);

  ClothItemManager get _clothItemManager => GetIt.I.get<ClothItemManager>();
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
