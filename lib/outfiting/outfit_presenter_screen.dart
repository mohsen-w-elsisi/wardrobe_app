import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_grid_view.dart';

class OutfitPresenterScreen extends StatelessWidget {
  final List<ClothItem> clothItems;

  const OutfitPresenterScreen(this.clothItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar.medium(
            title: Text("Outfit"),
          ),
          ClothItemGridView(clothItems, sliver: true),
        ],
      ),
    );
  }
}
