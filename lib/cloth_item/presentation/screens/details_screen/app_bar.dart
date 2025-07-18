import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/editing_screen/editing_screen.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/matching_dialog.dart';

class ClothItemDetailScreenAppBar extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemDetailScreenAppBar({
    required this.clothItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      title: Text(clothItem.name, overflow: TextOverflow.ellipsis),
      pinned: false,
      actions: [
        _FavouriteButton(clothItem: clothItem),
        _MatchingItemsButton(clothItem: clothItem),
        _EditButton(clothItem: clothItem),
        _DeleteButton(clothItem: clothItem),
      ],
    );
  }
}

class _FavouriteButton extends StatelessWidget {
  final ClothItem clothItem;

  const _FavouriteButton({required this.clothItem});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _toggleItemFavourite,
      icon: _favouriteIcon,
      tooltip: "favorite",
    );
  }

  Widget get _favouriteIcon => Icon(
        clothItem.isFavourite ? Icons.favorite : Icons.favorite_outline,
        color: clothItem.isFavourite ? Colors.red : null,
      );

  void _toggleItemFavourite() =>
      GetIt.I<ClothItemFavouriteToggler>().toggleItem(clothItem);
}

class _MatchingItemsButton extends StatelessWidget {
  final ClothItem clothItem;

  const _MatchingItemsButton({required this.clothItem});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showMatchingItemsDialoG(context),
      icon: const Icon(Icons.join_full_outlined),
      tooltip: "pair with items",
    );
  }

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
}

class _EditButton extends StatelessWidget {
  final ClothItem clothItem;

  const _EditButton({required this.clothItem});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _openEditScreen(context),
      icon: const Icon(Icons.edit_outlined),
      tooltip: "edit",
    );
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
}

class _DeleteButton extends StatelessWidget {
  final ClothItem clothItem;

  const _DeleteButton({required this.clothItem});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _deleteItem(context),
      icon: const Icon(Icons.delete_outline),
      tooltip: "delete",
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
}
