import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_detail_screen.dart';
import 'cloth_item_views_utils.dart';

class ClothItemListView extends StatelessWidget {
  final List<ClothItem> clothItems;
  final bool sliver;

  const ClothItemListView(
    this.clothItems, {
    this.sliver = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = clothItems.length;
    separatorBuilder(_, __) => const Divider();
    itemBuilder(_, int i) => ClothItemListTile(clothItems[i]);

    if (sliver) {
      return SliverList.separated(
        itemCount: itemCount,
        separatorBuilder: separatorBuilder,
        itemBuilder: itemBuilder,
      );
    } else {
      return ListView.separated(
        itemCount: itemCount,
        separatorBuilder: separatorBuilder,
        itemBuilder: itemBuilder,
      );
    }
  }
}

class ClothItemListTile extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemListTile(this.clothItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _navigateToDetailsPage(context),
      title: Text(clothItem.name),
      subtitle: Text(clothTypeTextMap[clothItem.type] ?? ""),
      trailing: SizedBox(
        width: 100,
        child: ClothItemAttributeIconRow(
          clothItem.attributes,
          alignEnd: true,
        ),
      ),
    );
  }

  void _navigateToDetailsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ClothItemDetailScreen(clothItem.id),
      ),
    );
  }
}
