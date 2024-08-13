import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/grid_view.dart';

class OutfitPresenterScreen extends StatelessWidget {
  final List<ClothItem> clothItems;

  const OutfitPresenterScreen(this.clothItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _AppBar(clothItems: clothItems),
          ClothItemGridView(clothItems, sliver: true),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final List<ClothItem> clothItems;

  _AppBar({required this.clothItems});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      actions: _actions,
      title: const Text("Outfit"),
    );
  }

  List<Widget> get _actions {
    return [
      _shareButton,
      _saveButton,
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
    final xFiles = [for (final item in clothItems) XFile.fromData(item.image)];
    Share.shareXFiles(xFiles, text: "what do you think of this outfit");
  }

  IconButton get _saveButton {
    return IconButton(
      tooltip: "save",
      onPressed: () {},
      icon: const Icon(Icons.save_alt),
    );
  }
}
