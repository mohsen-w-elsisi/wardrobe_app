import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/dispay_options/sort_mode.dart';

part 'settings.freezed.dart';

const layoutSwitchAnimationDuration = Duration(milliseconds: 400);

class ClothItemCompoundViewManager with ChangeNotifier {
  List<ClothItem> _clothItems;
  ClothItemCompoundViewSettings _settings;

  ClothItemCompoundViewManager({
    required List<ClothItem> clothItems,
    required ClothItemCompoundViewSettings settings,
  })  : _clothItems = clothItems,
        _settings = settings;

  List<ClothItem> get clothItems => List.unmodifiable(_clothItems);

  set clothItems(List<ClothItem> newClothitems) {
    _clothItems = newClothitems;
    notifyListeners();
  }

  ClothItemCompoundViewSettings get settings => _settings;

  void setLayout(ClothItemCompoundViewLayout layout) {
    _settings = _settings.copyWith(layout: layout);
    notifyListeners();
  }

  void setSortMode(ClothItemSortMode sortMode) {
    _settings = _settings.copyWith(sortMode: sortMode);
    notifyListeners();
  }

  void setFilteredAttributes(Set<ClothItemAttribute> attributes) {
    _settings = _settings.copyWith(filteredAttributes: attributes);
    notifyListeners();
  }

  bool layoutIs(ClothItemCompoundViewLayout testLayout) =>
      testLayout == _settings.layout;

  bool sortModeIs(ClothItemSortMode testSortMode) =>
      testSortMode == _settings.sortMode;
}

@freezed
class ClothItemCompoundViewSettings with _$ClothItemCompoundViewSettings {
  const factory ClothItemCompoundViewSettings({
    @Default(ClothItemCompoundViewLayout.grid)
    ClothItemCompoundViewLayout layout,
    @Default(ClothItemSortMode.byName) ClothItemSortMode sortMode,
    @Default({}) Set<ClothItemAttribute> filteredAttributes,
  }) = _ClothItemCompoundViewSettings;
}

enum ClothItemCompoundViewLayout { list, grid }
