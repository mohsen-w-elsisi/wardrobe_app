import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_organiser.dart';

class ClothItemGroupedList extends StatelessWidget {
  final List<ClothItem> clothItems;
  final ClothItemTileTapCallback? onTap;

  const ClothItemGroupedList({
    required this.clothItems,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final type in ClothItemType.values)
          _TypedListSection(
            type: type,
            clothItems: clothItems,
            onTap: onTap,
          )
      ],
    );
  }
}

class _TypedListSection extends StatelessWidget {
  final ClothItemType type;
  final List<ClothItem> clothItems;
  final ClothItemTileTapCallback? onTap;
  late final ClothItemOrganiser _clothItemOrganiser;

  _TypedListSection({
    required this.type,
    required this.clothItems,
    this.onTap,
  }) {
    _clothItemOrganiser = ClothItemOrganiser(clothItems);
  }

  @override
  Widget build(BuildContext context) {
    if (_listTiles.isEmpty) return Container();
    return Column(
      children: [
        _header(context),
        ..._listTiles,
      ],
    );
  }

  Widget _header(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          type.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );

  List<Widget> get _listTiles => [
        for (final item in _clothItemOrganiser.filterClothItemBytype(type))
          _ListTile(
            item: item,
            onTap: onTap != null ? () => onTap!(item) : null,
          )
      ];
}

class _ListTile extends StatelessWidget {
  final ClothItem item;
  final void Function()? onTap;

  const _ListTile({
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(0),
      title: Text(item.name),
      dense: true,
      titleTextStyle: Theme.of(context).textTheme.labelSmall,
    );
  }
}

typedef ClothItemTileTapCallback = void Function(ClothItem);
