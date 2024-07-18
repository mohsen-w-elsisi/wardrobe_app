import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views.dart';

class ClothItemListView extends StatelessWidget {
  final List<ClothItem> clothItems;

  const ClothItemListView(this.clothItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: clothItems.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, i) => ClothItemListTile(clothItems[i]),
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
      subtitle: Text(clothTypeTextMap[clothItem.type] ?? ""),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: clothItem.attributes
              .map((e) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(clothAttributeIconMap[e]),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
