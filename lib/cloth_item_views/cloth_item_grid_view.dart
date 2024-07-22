import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views.dart';
import 'cloth_item_views_utils.dart';

class ClothItemGridView extends StatelessWidget {
  final List<ClothItem> clothItems;

  const ClothItemGridView(this.clothItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 1,
      mainAxisSpacing: 2,
      crossAxisCount: 2,
      children: clothItems.map((e) => ClothItemGridCard(e)).toList(),
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
          builder: (_) => ClothItemDetailScreen(clothItem),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Expanded(child: Placeholder()),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Text(
                  clothItem.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              ClothItemAttributeIconRow(clothItem.attributes),
            ],
          ),
        ),
      ),
    );
  }
}
