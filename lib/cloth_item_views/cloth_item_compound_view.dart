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
      builder: (_, __) => ListView(
        children: [
          _ControlBar(settingsController),
          _LayoutSwitcher(
            clothItems: _sortedClothItems,
            currentLayout: settingsController.settings.layout,
          ),
        ],
      ),
    );
  }

  List<ClothItem> get _sortedClothItems {
    final clothItemOrganiser = ClothItemOrganiser(clothItems);
    final sortMode = settingsController.settings.sortMode;
    return clothItemOrganiser.sortFavouritesFirst(sortMode);
  }
}

class _LayoutSwitcher extends StatefulWidget {
  final List<ClothItem> clothItems;
  final ClothItemCompoundViewLayout currentLayout;

  const _LayoutSwitcher({
    super.key,
    required this.clothItems,
    required this.currentLayout,
  });

  @override
  State<_LayoutSwitcher> createState() => _LayoutSwitcherState();
}

class _LayoutSwitcherState extends State<_LayoutSwitcher>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 400);

  late final AnimationController _controller;
  late final Animation<double> _toListAnimation;
  late final Animation<double> _toGridAnimation;

  bool _showGrid = true;
  bool _showList = true;

  @override
  void initState() {
    super.initState();
    _initController();
    _initLayoutVisibilatyUpdates();
    _initCurvedAnimations();
  }

  void _initController() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
  }

  void _initLayoutVisibilatyUpdates() {
    _controller.addStatusListener(
      (_) => _updateLayoutVisibilities(),
    );
  }

  void _updateLayoutVisibilities() {
    setState(() {
      if (_controller.isAnimating) {
        _showList = true;
        _showGrid = true;
      } else {
        _showGrid = _layoutIsGrid;
        _showList = !_layoutIsGrid;
      }
    });
  }

  void _initCurvedAnimations() {
    _toGridAnimation = _curvedAnimation(Curves.easeInQuart);
    _toListAnimation = _curvedAnimation(Curves.easeOutQuart);
  }

  Animation<double> _curvedAnimation(Curve curve) {
    return Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: curve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _runSwitchAnimation();

    return Stack(
      children: [
        if (_showGrid) _gridAnimatedLayout,
        if (_showList) _listAnimatedLayout,
      ],
    );
  }

  Widget get _listAnimatedLayout {
    return _AnimatedLayout(
      controller: _controller,
      layout: _listView,
      xPosition: _listPosition,
      opacity: _listOpacity,
    );
  }

  Widget get _gridAnimatedLayout {
    return _AnimatedLayout(
      controller: _controller,
      layout: _gridView,
      xPosition: _gridPosition,
      opacity: _grdiOpacity,
    );
  }

  void _runSwitchAnimation() {
    if (_layoutIsGrid) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  double _grdiOpacity() => 1 - _currentAnimation.value;
  double _listOpacity() => _currentAnimation.value;

  double _gridPosition() => -(_currentAnimation.value * _screenWidth);
  double _listPosition() =>
      _screenWidth - (_currentAnimation.value * _screenWidth);

  Animation<double> get _currentAnimation =>
      _layoutIsGrid ? _toGridAnimation : _toListAnimation;

  double get _screenWidth => MediaQuery.of(context).size.width;

  Widget get _gridView => ClothItemGridView(
        widget.clothItems,
        nonScrollable: true,
        key: const Key("grid layout"),
      );

  Widget get _listView => ClothItemListView(
        widget.clothItems,
        nonScrollable: true,
        key: const Key("list layout"),
      );

  bool get _layoutIsGrid =>
      widget.currentLayout == ClothItemCompoundViewLayout.grid;
}

class _AnimatedLayout extends AnimatedWidget {
  const _AnimatedLayout({
    super.key,
    required this.controller,
    required this.layout,
    required this.xPosition,
    required this.opacity,
  }) : super(listenable: controller);

  final AnimationController controller;
  final Widget layout;
  final double Function() xPosition;
  final double Function() opacity;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(xPosition(), 0),
      child: Opacity(
        opacity: opacity(),
        child: layout,
      ),
    );
  }
}

class _ControlBar extends StatelessWidget {
  final ClothItemCompoundViewSettingsController settingsController;

  const _ControlBar(this.settingsController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _sortByLabel(context),
        _sortModeDropDown(),
        const Spacer(),
        _layoutToggleButton()
      ],
    );
  }

  Widget _sortByLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        "sort by ",
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  Widget _layoutToggleButton() {
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
        _controller.reverse();
      case ClothItemCompoundViewLayout.grid:
        _controller.forward();
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
