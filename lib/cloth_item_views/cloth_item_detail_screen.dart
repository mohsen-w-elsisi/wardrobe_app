import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_editers/cloth_item_matching_dialog.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_screen.dart';
import 'package:wardrobe_app/outfiting/outfit_maker_screen.dart';
import './cloth_item_image.dart';
import './cloth_item_views.dart';
import './cloth_item_views_utils.dart';

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
    if (_itemExists) {
      return ListenableBuilder(
        listenable: clothItemManager,
        builder: (_, __) => Scaffold(
          body: CustomScrollView(slivers: _componentSlivers),
          floatingActionButton: _StartOutfitFAB(clothItem: _clothItem!),
        ),
      );
    } else {
      return Container();
    }
  }

  List<Widget> get _componentSlivers => [
        _AppBar(clothItem: _clothItem!),
        _Image(clothItem: _clothItem!, enableHeroImage: enableHeroImage),
        _AttributeChips(clothItem: _clothItem!),
        _MatchingItemList(clothItem: _clothItem!),
      ];

  bool get _itemExists => _clothItem != null;

  ClothItem? get _clothItem => clothItemManager.getClothItemById(clothItemId);
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
      title: Text(clothItem.name, overflow: TextOverflow.ellipsis),
      actions: [
        IconButton(
          onPressed: _toggleItemFavourite,
          icon: _favouriteIcon,
        ),
        IconButton(
          onPressed: () => _showMatchingItemsDialoG(context),
          icon: const Icon(Icons.join_full_outlined),
        ),
        IconButton(
          onPressed: () => _openEditScreen(context),
          icon: const Icon(Icons.edit_outlined),
        ),
        IconButton(
          onPressed: () => _deleteItem(context),
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }

  Widget get _favouriteIcon => Icon(
        clothItem.isFavourite ? Icons.favorite : Icons.favorite_outline,
        color: clothItem.isFavourite ? Colors.red : null,
      );

  void _showMatchingItemsDialoG(BuildContext context) {
    final newClothItemManager = NewClothItemManager.from(clothItem);
    ClothItemMatchingDialog(
      newClothItemManager: newClothItemManager,
      clothItem: clothItem,
      onDismiss: (context) => clothItemManager.saveItem(
        newClothItemManager.clothItem,
      ),
    ).show(context);
  }

  void _openEditScreen(BuildContext context) {
    final newClothItemManager = NewClothItemManager.from(clothItem);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewClothItemScreen(
          newClothItemManager: newClothItemManager,
          showMatchingsDialog: false,
        ),
      ),
    );
  }

  void _deleteItem(BuildContext context) {
    clothItemManager.deleteItem(clothItem);
    Navigator.pop(context);
    _showDeletionSnackBar(context);
  }

  void _showDeletionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${clothItem.name} deleted"),
      ),
    );
  }

  void _toggleItemFavourite() =>
      clothItemManager.toggleFavouriteForItem(clothItem);
}

class _StartOutfitFAB extends StatelessWidget {
  final ClothItem clothItem;

  const _StartOutfitFAB({
    required this.clothItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _openDetailsScreen(context),
      child: const Icon(Icons.checkroom_outlined),
    );
  }

  void _openDetailsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OutfitMakerScreen(
          preSelectedItems: [clothItem],
        ),
      ),
    );
  }
}
