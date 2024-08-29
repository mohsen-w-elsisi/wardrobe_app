import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/organiser.dart';

import 'cnotrol_bar.dart';
import 'layout_switcher.dart';
import 'settings.dart';

class ClothItemCompoundView extends StatelessWidget {
  final ClothItemCompoundViewManager _settingsManager;

  const ClothItemCompoundView(this._settingsManager, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settingsManager,
      builder: (_, __) =>
          _settingsManager.clothItems.isNotEmpty ? _mainView : _noItemsMessage,
    );
  }

  Widget get _noItemsMessage {
    return const Center(
      child: Text("no items saved yet"),
    );
  }

  Widget get _mainView {
    return ListView(
      children: [
        ClothItemCompoundViewControlBar(_settingsManager),
        ClothItemCompoundViewLayoutSwitcher(
          clothItems: _sortedFilteredClothItems,
          currentLayout: _settingsManager.settings.layout,
        ),
      ],
    );
  }

  List<ClothItem> get _sortedFilteredClothItems {
    final clothItemOrganiser = ClothItemOrganiser(_filteredClothItems);
    final sortMode = _settingsManager.settings.sortMode;
    return clothItemOrganiser.sortFavouritesFirst(sortMode);
  }

  List<ClothItem> get _filteredClothItems {
    final filterAttributes = _settingsManager.settings.filteredAttributes;
    final clothItemOrganiser = ClothItemOrganiser(_settingsManager.clothItems);
    return clothItemOrganiser.filterUsingAttributes(filterAttributes);
  }
}
