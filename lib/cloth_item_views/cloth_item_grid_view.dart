import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views.dart';
import 'cloth_item_image.dart';
import 'cloth_item_views_utils.dart';

class ClothItemGridView extends StatelessWidget {
  final List<ClothItem> clothItems;
  final bool sliver;

  const ClothItemGridView(this.clothItems, {this.sliver = false, super.key});

  @override
  Widget build(BuildContext context) {
    final clothItemCards = clothItems.map((e) => ClothItemGridCard(e)).toList();

    return sliver
        ? SliverGrid.count(
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            crossAxisCount: 2,
            childAspectRatio: 7 / 10,
            children: clothItemCards,
          )
        : GridView.count(
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            crossAxisCount: 2,
            childAspectRatio: 7 / 10,
            children: clothItemCards,
          );
  }
}

class ClothItemGridCard extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemGridCard(this.clothItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ClothItemDetailScreen(clothItem.id),
        ),
      ),
      child: Card(
        child: Column(
          children: [
            Hero(
              tag: clothItem.id,
              child: ClothItemImage(image: clothItem.image),
            ),
            ListTile(
              title: Text(clothItem.name),
              subtitle: ClothItemAttributeIconRow(clothItem.attributes),
            )
          ],
        ),
      ),
    );
  }
}
