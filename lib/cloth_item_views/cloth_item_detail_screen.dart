import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item.dart';

class ClothItemDetailScreen extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemDetailScreen(this.clothItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          ClothItemDetailScreenAppBar(clothItem: clothItem),
          ClothItemDetailScreenAttributeChips(clothItem: clothItem),
          SliverList.list(
            children: const [],
          )
        ],
      ),
    );
  }
}

class ClothItemDetailScreenAttributeChips extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemDetailScreenAttributeChips({
    super.key,
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          for (final attribute in clothItem.attributes)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(label: Text(attribute.name)),
            )
        ],
      ),
    );
  }
}

class ClothItemDetailScreenAppBar extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemDetailScreenAppBar({
    super.key,
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      title: Text(clothItem.name),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_outline),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.join_full_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }
}
