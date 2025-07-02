import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/list_view.dart';

class ClothItemDetailScreenMatchingItemList extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemDetailScreenMatchingItemList({
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _matchingItems,
      builder: (_, snapshot) {
        return ClothItemListView(
          snapshot.data ?? [],
          sliver: true,
        );
      },
    );
  }

  Future<List<ClothItem>> get _matchingItems =>
      GetIt.I<ClothItemMatcher>().findMatchingItemsOfSeason(clothItem);
}
