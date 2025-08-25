import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

import '../screens/details_screen/details_screen.dart';
import 'image.dart';
import 'attribute_icon_row.dart';

class ClothItemGridView extends StatelessWidget {
  static const _cardAspectRation = 7 / 10;

  final List<ClothItem> clothItems;
  final bool sliver;
  final bool nonScrollable;

  const ClothItemGridView(
    this.clothItems, {
    this.sliver = false,
    this.nonScrollable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return sliver
        ? SliverGrid.count(
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            crossAxisCount: 2,
            childAspectRatio: _cardAspectRation,
            children: _clothItemCards,
          )
        : GridView.count(
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            crossAxisCount: 2,
            childAspectRatio: _cardAspectRation,
            shrinkWrap: nonScrollable,
            physics: _scrollPhysics,
            children: _clothItemCards,
          );
  }

  List<_GridCard> get _clothItemCards =>
      clothItems.map((e) => _GridCard(e)).toList();

  ScrollPhysics get _scrollPhysics => nonScrollable
      ? const NeverScrollableScrollPhysics()
      : const AlwaysScrollableScrollPhysics();
}

class _GridCard extends StatelessWidget {
  final ClothItem clothItem;

  const _GridCard(this.clothItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ClothItemDetailScreen(clothItem),
        ),
      ),
      child: Card(
        child: Column(
          children: [
            Hero(
              tag: clothItem.id,
              child: ClothItemImage(clothItem: clothItem),
            ),
            ListTile(
              title: Text(clothItem.name, overflow: TextOverflow.ellipsis),
              subtitle: ClothItemAttributeIconRow(clothItem.attributes),
            )
          ],
        ),
      ),
    );
  }
}
