import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/manager.dart';
import 'package:wardrobe_app/cloth_item_views/grid_view.dart';
import 'package:wardrobe_app/outfit/outfit.dart';

import 'saving_modal.dart';

class OutfitPresenterScreen extends StatelessWidget {
  final Outfit outfit;

  const OutfitPresenterScreen(this.outfit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _AppBar(outfit: outfit),
          ClothItemGridView(_clothItems, sliver: true),
        ],
      ),
    );
  }

  List<ClothItem> get _clothItems {
    final clothItemManager = GetIt.I.get<ClothItemManager>();
    return outfit.items
        .map(clothItemManager.getClothItemById)
        .nonNulls
        .toList();
  }
}

class _AppBar extends StatelessWidget {
  final Outfit outfit;

  const _AppBar({required this.outfit});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      actions: _actions(context),
      title: Text(outfit.isEphemiral ? "new outfit" : outfit.name),
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [
      _shareButton,
      _saveButton(context),
    ];
  }

  IconButton get _shareButton {
    return IconButton(
      tooltip: "share",
      onPressed: _share,
      icon: const Icon(Icons.share),
    );
  }

  void _share() {
    final files = [for (final item in _clothItems) XFile.fromData(item.image)];
    Share.shareXFiles(files, text: "what do you think of this outfit");
  }

  List<ClothItem> get _clothItems {
    final clothitemManager = GetIt.I.get<ClothItemManager>();
    return outfit.items
        .map(clothitemManager.getClothItemById)
        .nonNulls
        .toList();
  }

  IconButton _saveButton(BuildContext context) {
    return IconButton(
      tooltip: "save",
      onPressed: () => _showSavingModal(context),
      icon: const Icon(Icons.bookmark_add_outlined),
    );
  }

  void _showSavingModal(BuildContext context) {
    OutfitSavingDialog(outfit: outfit).show(context);
  }
}
