import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/details_screen.dart';
import 'package:wardrobe_app/cloth_item_views/dispay_options/type.dart';
import 'utils.dart';

class ClothItemListView extends StatelessWidget {
  final List<ClothItem> clothItems;
  final bool sliver;
  final bool nonScrollable;

  const ClothItemListView(
    this.clothItems, {
    this.sliver = false,
    this.nonScrollable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return sliver
        ? SliverList.separated(
            itemCount: _itemCount,
            separatorBuilder: separatorBuilder,
            itemBuilder: itemBuilder,
          )
        : ListView.separated(
            itemCount: _itemCount,
            separatorBuilder: separatorBuilder,
            shrinkWrap: nonScrollable,
            physics: _scrollPhysics,
            itemBuilder: itemBuilder,
          );
  }

  Widget separatorBuilder(_, __) => const Divider();
  Widget itemBuilder(_, int i) => _ListTile(clothItems[i]);

  int get _itemCount => clothItems.length;

  ScrollPhysics get _scrollPhysics => nonScrollable
      ? const NeverScrollableScrollPhysics()
      : const AlwaysScrollableScrollPhysics();
}

class _ListTile extends StatelessWidget {
  final ClothItem clothItem;

  const _ListTile(this.clothItem);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      closedColor: Theme.of(context).colorScheme.surface,
      closedBuilder: (_, __) => _minimisedListTile(),
      openBuilder: (_, __) => _maximisedDetailScreen(),
    );
  }

  Widget _minimisedListTile() {
    return ListTile(
      title: Text(clothItem.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(clothItemTypeDisplayOptions[clothItem.type]!.text),
      trailing: SizedBox(
        width: 100,
        child: ClothItemAttributeIconRow(
          clothItem.attributes,
          alignEnd: true,
        ),
      ),
    );
  }

  Widget _maximisedDetailScreen() {
    return ClothItemDetailScreen(clothItem.id);
  }
}
