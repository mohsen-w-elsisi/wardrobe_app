import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

import 'describter_chips.dart';
import 'image.dart';
import 'matching_item_list.dart';
import 'start_outfit_FAB.dart';
import 'app_bar.dart';

class ClothItemDetailScreen extends StatelessWidget {
  final ClothItem item;
  final bool enableHeroImage;

  const ClothItemDetailScreen(
    this.item, {
    this.enableHeroImage = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GetIt.I<ClothItemUiNotifier>(),
      builder: (_, __) => FutureBuilder(
        future: GetIt.I<ClothItemQuerier>().getById(item.id),
        initialData: item,
        builder: (_, snapshot) {
          return Scaffold(
            body: CustomScrollView(
              slivers: _componentSlivers(snapshot.data!),
            ),
            floatingActionButton:
                ClothItemDetailScreenStartOutfitFAB(clothItem: snapshot.data!),
          );
        },
      ),
    );
  }

  List<Widget> _componentSlivers(ClothItem item) {
    return [
      ClothItemDetailScreenAppBar(clothItem: item),
      ClothItemDetailScreenImage(
          clothItem: item, enableHeroImage: enableHeroImage),
      ClothItemDetailScreenDescribterChips(clothItem: item),
      ClothItemDetailScreenMatchingItemList(clothItem: item),
    ];
  }
}
