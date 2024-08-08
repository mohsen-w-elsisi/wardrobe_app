import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_organiser.dart';

import 'cloth_item_grid_view.dart';
import 'cloth_item_list_view.dart';
import 'cloth_item_views_utils.dart';

class ClothItemCompoundView extends StatelessWidget {
  final List<ClothItem> clothItems;

  final settingsController = ClothItemCompoundViewSettingsController(
    ClothItemCompoundViewSettings.defaultSettings(),
  );

  ClothItemCompoundView(this.clothItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (_, __) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _ControlBar(settingsController),
          ),
          _currentLayout,
        ],
      ),
    );
  }

  Widget get _currentLayout =>
      settingsController.layoutIs(ClothItemCompoundViewLayout.grid)
          ? ClothItemGridView(_sortedClothItems)
          : ClothItemListView(_sortedClothItems);

  List<ClothItem> get _sortedClothItems {
    final clothItemOrganiser = ClothItemOrganiser(clothItems);
    final sortMode = settingsController.settings.sortMode;
    return clothItemOrganiser.sortFavouritesFirst(sortMode);
  }
}

class _ControlBar extends StatelessWidget {
  final ClothItemCompoundViewSettingsController settingsController;

  const _ControlBar(this.settingsController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "sort by ",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        _sortModeDropDown(),
        const Spacer(),
        _layoutToggleButton()
      ],
    );
  }

  IconButton _layoutToggleButton() {
    return IconButton(
      onPressed: toggleLayout,
      icon: _LayoutToggleIcon(
        layout: settingsController.settings.layout,
      ),
    );
  }

  DropdownButton<ClothItemSortMode> _sortModeDropDown() {
    return DropdownButton(
      icon: const Icon(Icons.sort),
      value: settingsController.settings.sortMode,
      onChanged: (value) => settingsController.setSortMode(value!),
      items: [
        for (final sortMode in ClothItemSortMode.values)
          DropdownMenuItem(
            value: sortMode,
            child: Text(sortModeLabelMap[sortMode]!),
          )
      ],
    );
  }

  void toggleLayout() => settingsController.setLayout(
        settingsController.layoutIs(ClothItemCompoundViewLayout.grid)
            ? ClothItemCompoundViewLayout.list
            : ClothItemCompoundViewLayout.grid,
      );
}

class _LayoutToggleIcon extends StatefulWidget {
  final ClothItemCompoundViewLayout layout;

  const _LayoutToggleIcon({super.key, required this.layout});

  @override
  State<_LayoutToggleIcon> createState() => _LayoutToggleIconState();
}

class _LayoutToggleIconState extends State<_LayoutToggleIcon>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateAnimationProgress();
    return AnimatedIcon(
      icon: AnimatedIcons.view_list,
      progress: _controller,
    );
  }

  void _updateAnimationProgress() {
    switch (widget.layout) {
      case ClothItemCompoundViewLayout.list:
        _controller.forward();
      case ClothItemCompoundViewLayout.grid:
        _controller.reverse();
    }
  }
}

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
