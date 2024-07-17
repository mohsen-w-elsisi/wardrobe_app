import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item.dart';
import 'package:wardrobe_app/home_screen.dart';

class ClothItemCompoundView extends StatelessWidget {
  final List<ClothItem> clothItems;

  const ClothItemCompoundView(this.clothItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClothItemListView(clothItems);
  }
}

class ClothItemListView extends StatelessWidget {
  final List<ClothItem> clothItems;

  const ClothItemListView(this.clothItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: mockClothItems.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, i) => ClothItemListTile(mockClothItems[i]),
    );
  }
}

class ClothItemListTile extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemListTile(this.clothItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(clothItem.name),
    );
  }
}
