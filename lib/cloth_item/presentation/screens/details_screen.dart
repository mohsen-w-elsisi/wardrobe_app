import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/seasons.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/matching_dialog.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/editing_screen/editing_screen.dart';
import 'package:wardrobe_app/outfit/views/maker_screen/maker_screen.dart';

import '../shared_presenters/display_configs/attributes.dart';
import '../shared_widgets/image.dart';
import '../shared_widgets/list_view.dart';

class ClothItemDetailScreen extends StatelessWidget {
  final String itemId;
  final bool enableHeroImage;

  const ClothItemDetailScreen(
    this.itemId, {
    this.enableHeroImage = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GetIt.I<ClothItemUiNotifier>(),
      builder: (_, __) => FutureBuilder(
        future: _clothItem,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final item = snapshot.data!;
            return _filledDetailsView(item);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _filledDetailsView(ClothItem item) {
    return Scaffold(
      body: CustomScrollView(
        slivers: _componentSlivers(item),
      ),
      floatingActionButton: _StartOutfitFAB(clothItem: item),
    );
  }

  List<Widget> _componentSlivers(ClothItem item) {
    return [
      _AppBar(clothItem: item),
      _Image(clothItem: item, enableHeroImage: enableHeroImage),
      _DescribterChips(clothItem: item),
      _MatchingItemList(clothItem: item),
    ];
  }

  Future<ClothItem> get _clothItem =>
      GetIt.I<ClothItemQuerier>().getById(itemId);
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
  final ClothItem clothItem;

  const _MatchingItemList({
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _matchingItems,
      builder: (_, snapshot) {
        return ClothItemListView(
          snapshot.data ?? [],
          sliver: true,
        );
      },
    );
  }

  Future<List<ClothItem>> get _matchingItems =>
      GetIt.I<ClothItemMatcher>().findMatchingItems(clothItem);
}

class _DescribterChips extends StatelessWidget {
  final ClothItem clothItem;

  const _DescribterChips({
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          spacing: 8.0,
          children: _chips,
        ),
      ),
    );
  }

  List<Widget> get _chips {
    return [
      if (clothItem.season != Season.all) _seasonChip,
      ..._attributeChips,
    ];
  }

  Widget get _seasonChip {
    return Chip(
      label: Text(seasonDisplayConfigs[clothItem.season]!.name),
      avatar: Icon(seasonDisplayConfigs[clothItem.season]!.icon),
    );
  }

  List<Widget> get _attributeChips {
    return [
      for (final attribute in clothItem.attributes)
        Chip(
          label: Text(clothItemAttributeDisplayOptions[attribute]!.name),
          avatar: Icon(clothItemAttributeDisplayOptions[attribute]!.icon),
        )
    ];
  }
}

class _AppBar extends StatelessWidget {
  final ClothItem clothItem;

  const _AppBar({
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
    final newClothItemManager = ClothItemEditingManager.from(clothItem);
    ClothItemMatchingDialog(
      newClothItemManager: newClothItemManager,
      clothItem: clothItem,
      onDismiss: (context) => GetIt.I<ClothItemSaver>().save(
        newClothItemManager.clothItem,
      ),
    ).show(context);
  }

  void _openEditScreen(BuildContext context) {
    final newClothItemManager = ClothItemEditingManager.from(clothItem);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ClothItemEditingScreen(
          editingManager: newClothItemManager,
          showMatchingsDialog: false,
        ),
      ),
    );
  }

  void _deleteItem(BuildContext context) {
    GetIt.I<ClothItemDeleter>().delete(clothItem);
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
      GetIt.I<ClothItemFavouriteToggler>().toggleItem(clothItem);
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
