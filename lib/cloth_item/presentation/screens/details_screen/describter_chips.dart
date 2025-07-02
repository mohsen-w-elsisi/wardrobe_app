import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/attributes.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/seasons.dart';
import 'package:wardrobe_app/shared/entities/season.dart';

class ClothItemDetailScreenDescribterChips extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemDetailScreenDescribterChips({
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          spacing: 8.0,
          children: _chips,
        ),
      ),
    );
  }

  List<Widget> get _chips {
    return [
      if (clothItem.season != Season.all) _seasonChip,
      ..._attributeChips,
    ];
  }

  Widget get _seasonChip {
    return Chip(
      label: Text(SeasonDisplayConfig.of(clothItem.season).name),
      avatar: Icon(SeasonDisplayConfig.of(clothItem.season).icon),
    );
  }

  List<Widget> get _attributeChips {
    return [
      for (final attribute in clothItem.attributes)
        Chip(
          label: Text(ClothItemAttributeDisplayConfig.of(attribute).name),
          avatar: Icon(ClothItemAttributeDisplayConfig.of(attribute).icon),
        )
    ];
  }
}
