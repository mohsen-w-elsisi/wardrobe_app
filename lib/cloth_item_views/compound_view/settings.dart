import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item_views/dispay_options/sort_mode.dart';

const layoutSwitchAnimationDuration = Duration(milliseconds: 400);

class ClothItemCompoundViewSettingsController extends ChangeNotifier {
  final ClothItemCompoundViewSettings settings;

  ClothItemCompoundViewSettingsController(this.settings);

  void setLayout(ClothItemCompoundViewLayout layout) {
    settings.layout = layout;
    notifyListeners();
  }

  void setSortMode(ClothItemSortMode sortMode) {
    settings.sortMode = sortMode;
    notifyListeners();
  }

  bool layoutIs(ClothItemCompoundViewLayout testLayout) =>
      testLayout == settings.layout;

  bool sortModeIs(ClothItemSortMode testSortMode) =>
      testSortMode == settings.sortMode;
}

class ClothItemCompoundViewSettings {
  ClothItemCompoundViewLayout layout;
  ClothItemSortMode sortMode;

  ClothItemCompoundViewSettings({
    required this.layout,
    required this.sortMode,
  });

  ClothItemCompoundViewSettings.defaultSettings()
      : layout = ClothItemCompoundViewLayout.grid,
        sortMode = ClothItemSortMode.byName;
}

enum ClothItemCompoundViewLayout { list, grid }
