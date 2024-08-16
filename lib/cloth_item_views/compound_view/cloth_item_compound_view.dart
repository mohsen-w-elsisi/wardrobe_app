import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/organiser.dart';

import 'cnotrol_bar.dart';
import 'layout_switcher.dart';
import 'settings.dart';

class ClothItemCompoundView extends StatelessWidget {
  final List<ClothItem> clothItems;

  final settingsController = ClothItemCompoundViewSettingsController(
    const ClothItemCompoundViewSettings(),
  );

  ClothItemCompoundView(this.clothItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (_, __) => ListView(
        children: [
          ClothItemCompoundViewControlBar(settingsController),
          ClothItemCompoundViewLayoutSwitcher(
            clothItems: _sortedFilteredClothItems,
            currentLayout: settingsController.settings.layout,
          ),
        ],
      ),
    );
  }

  List<ClothItem> get _sortedFilteredClothItems {
    final clothItemOrganiser = ClothItemOrganiser(_filteredClothItems);
    final sortMode = settingsController.settings.sortMode;
    return clothItemOrganiser.sortFavouritesFirst(sortMode);
  }

  List<ClothItem> get _filteredClothItems {
    final filterAttributes = settingsController.settings.filteredAttributes;
    final clothItemOrganiser = ClothItemOrganiser(clothItems);
    return clothItemOrganiser.filterUsingAttributes(filterAttributes);
  }
}
