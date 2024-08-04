import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_editers/cloth_item_matching_dialog.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_screen.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_image.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views_utils.dart';

class ClothItemDetailScreen extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final String clothItemId;
  final bool enableHeroImage;

  ClothItemDetailScreen(
    this.clothItemId, {
    this.enableHeroImage = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: clothItemManager,
        builder: (_, __) {
          return CustomScrollView(
            slivers: <Widget>[
              _AppBar(clothItem: clothItem),
              _Image(clothItem: clothItem, enableHeroImage: enableHeroImage),
              _AttributeChips(clothItem: clothItem),
              _MatchingItemList(clothItem: clothItem),
            ],
          );
        },
      ),
    );
  }

  ClothItem get clothItem => clothItemManager.getClothItemById(clothItemId)!;
}

class _Image extends StatelessWidget {
  final ClothItem clothItem;
  final bool enableHeroImage;

  const _Image({
    super.key,
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

  Widget get _clothItemImage => ClothItemImage(image: clothItem.image);
}

class _MatchingItemList extends StatelessWidget {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();
  final ClothItem clothItem;

  _MatchingItemList({
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

class _AttributeChips extends StatelessWidget {
  final ClothItem clothItem;

  const _AttributeChips({
    super.key,
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          children: [
            for (final attribute in clothItem.attributes)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(
                  label: Text(attribute.name),
                  avatar: Icon(clothAttributeIconMap[attribute]),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final ClothItem clothItem;

  _AppBar({
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
          onPressed: () {
            final newClothItemManager = NewClothItemManager.from(clothItem);
            ClothItemMatchingDialog(
              newClothItemManager: newClothItemManager,
              onDismiss: (context) => clothItemManager.saveItem(
                newClothItemManager.clothItem,
              ),
            ).show(context);
          },
          icon: const Icon(Icons.join_full_outlined),
        ),
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewClothItemScreen(
                newClothItemManager: NewClothItemManager.from(clothItem),
                showMatchingsDialog: false,
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            clothItemManager.deleteItem(clothItem);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
