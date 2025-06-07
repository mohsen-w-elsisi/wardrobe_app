import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presenters/organiser.dart';
import 'package:wardrobe_app/cloth_item/views/compound_view/filter_chips.dart';

import 'cnotrol_bar.dart';
import 'layout_switcher/layout_switcher.dart';
import 'settings.dart';

class ClothItemCompoundView extends StatelessWidget {
  final ClothItemCompoundViewManager _settingsManager;
  final String _noItemsMessageText;

  const ClothItemCompoundView({
    super.key,
    required ClothItemCompoundViewManager settingsManager,
    required String noItemsMessageText,
  })  : _settingsManager = settingsManager,
        _noItemsMessageText = noItemsMessageText;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settingsManager,
      builder: (_, __) =>
          _settingsManager.clothItems.isNotEmpty ? _mainView : _noItemsMessage,
    );
  }

  Widget get _noItemsMessage {
    return Center(
      child: Text(_noItemsMessageText),
    );
  }

  Widget get _mainView {
    return ListView(
      children: [
        ClothItemCompoundViewControlBar(_settingsManager),
        ClothItemCompoundViewFilterChips(viewManager: _settingsManager),
        ClothItemCompoundViewLayoutSwitcher(
          clothItems: _sortedFilteredItems,
          currentLayout: _settingsManager.settings.layout,
        ),
      ],
    );
  }

  List<ClothItem> get _sortedFilteredItems {
    return _CompoundViewItemsFilterAndSorter(
      _settingsManager.clothItems,
      _settingsManager.settings,
    ).items;
  }
}

class _CompoundViewItemsFilterAndSorter {
  List<ClothItem> _items;
  final ClothItemCompoundViewSettings _viewSettings;

  _CompoundViewItemsFilterAndSorter(
    this._items,
    this._viewSettings,
  ) {
    _filterByType();
    _filterByAttribute();
    _sort();
  }

  List<ClothItem> get items => [..._items];

  void _filterByType() {
    final filterTypes = _viewSettings.filteredTypes;
    _items = _itemsOrganiser().filterUsingTypes(filterTypes);
  }

  void _filterByAttribute() {
    final filterAttributes = _viewSettings.filteredAttributes;
    _items = _itemsOrganiser().filterUsingAttributes(filterAttributes);
  }

  void _sort() {
    final sortMode = _viewSettings.sortMode;
    _items = _itemsOrganiser().sortFavouritesFirst(sortMode);
  }

  ClothItemOrganiser _itemsOrganiser() => ClothItemOrganiser(_items);
}
