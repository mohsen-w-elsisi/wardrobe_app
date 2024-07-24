import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views_utils.dart';

class ClothItemDetailScreen extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final String clothItemId;

  ClothItemDetailScreen(this.clothItemId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: clothItemManager,
        builder: (_, __) {
          final clothItem = clothItemManager.getClothItemById(clothItemId);
          if (clothItem == null) return Container();

          return CustomScrollView(
            slivers: <Widget>[
              ClothItemDetailScreenAppBar(clothItem: clothItem),
              ClothItemDetailScreenAttributeChips(clothItem: clothItem),
              ClothItemDetailScreenMatchingItemList(clothItem: clothItem),
            ],
          );
        },
      ),
    );
  }
}

class ClothItemDetailScreenMatchingItemList extends StatelessWidget {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();
  final ClothItem clothItem;

  ClothItemDetailScreenMatchingItemList({
    super.key,
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return ClothItemListView(
      _clothItemManager.getMatchingItems(clothItem),
      sliver: true,
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
              child: Chip(
                label: Text(attribute.name),
                avatar: Icon(clothAttributeIconMap[attribute]),
              ),
            )
        ],
      ),
    );
  }
}

class ClothItemDetailScreenAppBar extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final ClothItem clothItem;

  ClothItemDetailScreenAppBar({
    super.key,
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      title: Text(clothItem.name),
      actions: [
        IconButton(
          onPressed: () => clothItemManager.toggleFavouriteForItem(clothItem),
          icon: Icon(
            clothItem.isFavourite ? Icons.favorite : Icons.favorite_outline,
            color: Colors.red,
          ),
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
          onPressed: () {
            clothItemManager.deleteItem(clothItem);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }
}
