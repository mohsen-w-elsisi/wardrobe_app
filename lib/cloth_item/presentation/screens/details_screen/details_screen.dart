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

class ClothItemDetailScreen extends StatefulWidget {
  final String itemId;
  final bool enableHeroImage;

  const ClothItemDetailScreen(
    this.itemId, {
    this.enableHeroImage = true,
    super.key,
  });

  @override
  State<ClothItemDetailScreen> createState() => _ClothItemDetailScreenState();
}

class _ClothItemDetailScreenState extends State<ClothItemDetailScreen> {
  late bool _itemexists;
  late ClothItem _clothItem;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GetIt.I<ClothItemUiNotifier>(),
      builder: (_, __) => FutureBuilder(
        future: _fetchClothitem(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            if (_itemexists) {
              return _filledDetailsView(_clothItem);
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }

  Widget _filledDetailsView(ClothItem item) {
    return Scaffold(
      body: CustomScrollView(
        slivers: _componentSlivers(item),
      ),
      floatingActionButton:
          ClothItemDetailScreenStartOutfitFAB(clothItem: item),
    );
  }

  List<Widget> _componentSlivers(ClothItem item) {
    return [
      ClothItemDetailScreenAppBar(clothItem: item),
      ClothItemDetailScreenImage(
          clothItem: item, enableHeroImage: widget.enableHeroImage),
      ClothItemDetailScreenDescribterChips(clothItem: item),
      ClothItemDetailScreenMatchingItemList(clothItem: item),
    ];
  }

  Future<void> _fetchClothitem() async {
    try {
      _clothItem = await GetIt.I<ClothItemQuerier>().getById(widget.itemId);
      _itemexists = true;
    } on StateError {
      _itemexists = false;
    }
  }
}
