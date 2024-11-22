import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';
import 'package:wardrobe_app/cloth_item/views/matching_dialog.dart';
import 'package:wardrobe_app/cloth_item/backend/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/views/editing_screen/new_screen/editing_screen.dart';
import 'package:wardrobe_app/outfit/views/maker_screen/maker_screen.dart';

import '../dispay_options/attribute.dart';
import 'image.dart';
import 'list_view.dart';

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
    return ListenableBuilder(
      listenable: clothItemManager,
      builder: (_, __) {
        if (_itemExists) {
          return Scaffold(
            body: CustomScrollView(slivers: _componentSlivers),
            floatingActionButton: _StartOutfitFAB(clothItem: _clothItem!),
          );
        } else {
          return Container();
        }
      },
    );
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

class _MatchingItemList extends StatelessWidget {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();
  final ClothItem clothItem;

  _MatchingItemList({
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
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          children: _chips,
        ),
      ),
    );
  }

  List<Widget> get _chips {
    return [
      for (final attribute in clothItem.attributes)
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Chip(
            label: Text(clothItemAttributeDisplayOptions[attribute]!.name),
            avatar: Icon(clothItemAttributeDisplayOptions[attribute]!.icon),
          ),
        )
    ];
  }
}

class _AppBar extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final ClothItem clothItem;

  _AppBar({
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
          tooltip: "favorite",
        ),
        IconButton(
          onPressed: () => _showMatchingItemsDialoG(context),
          icon: const Icon(Icons.join_full_outlined),
          tooltip: "pair with items",
        ),
        IconButton(
          onPressed: () => _openEditScreen(context),
          icon: const Icon(Icons.edit_outlined),
          tooltip: "edit",
        ),
        IconButton(
          onPressed: () => _deleteItem(context),
          icon: const Icon(Icons.delete_outline),
          tooltip: "delete",
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
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "new outfit with this",
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
