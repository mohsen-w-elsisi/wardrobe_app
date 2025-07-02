import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/image.dart';

class ClothItemDetailScreenImage extends StatelessWidget {
  final ClothItem clothItem;
  final bool enableHeroImage;

  const ClothItemDetailScreenImage({
    required this.clothItem,
    required this.enableHeroImage,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: enableHeroImage ? _heroClothItemImage : _clothItemImage,
      ),
    );
  }

  Widget get _heroClothItemImage => Hero(
        tag: clothItem.id,
        child: _clothItemImage,
      );

  Widget get _clothItemImage => ClothItemImage(clothItem: clothItem);
}
