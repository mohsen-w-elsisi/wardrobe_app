import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/organiser.dart';
import 'package:wardrobe_app/cloth_item/dispay_options/type.dart';

class ClothItemGroupedList extends StatelessWidget {
  final List<ClothItem> clothItems;
  final ClothItemTypeTitleCallback? onTypeTap;
  final ClothItemTileTapCallback? onItemTap;

  const ClothItemGroupedList({
    required this.clothItems,
    this.onTypeTap,
    this.onItemTap,
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
            onTypeTap: onTypeTap,
            onItemTap: onItemTap,
          )
      ],
    );
  }
}

class _TypedListSection extends StatelessWidget {
  final ClothItemType type;
  final List<ClothItem> clothItems;
  final ClothItemTypeTitleCallback? onTypeTap;
  final ClothItemTileTapCallback? onItemTap;
  late final ClothItemOrganiser _clothItemOrganiser;

  _TypedListSection({
    required this.type,
    required this.clothItems,
    this.onTypeTap,
    this.onItemTap,
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

  Widget _header(BuildContext context) {
    return GestureDetector(
      onTap: onTypeTap == null ? () {} : () => onTypeTap!(type),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          clothItemTypeDisplayOptions[type]!.text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  List<Widget> get _listTiles {
    return [
      for (final item in _clothItemOrganiser.filterBytype(type))
        _ListTile(
          item: item,
          onTap: onItemTap != null ? () => onItemTap!(item) : null,
        )
    ];
  }
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
      contentPadding: const EdgeInsets.only(left: 8),
      title: Text(item.name),
      dense: true,
      titleTextStyle: Theme.of(context).textTheme.labelSmall,
    );
  }
}

typedef ClothItemTypeTitleCallback = void Function(ClothItemType);
typedef ClothItemTileTapCallback = void Function(ClothItem);
