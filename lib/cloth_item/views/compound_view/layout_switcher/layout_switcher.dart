import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';

import 'animated_layout_deligates.dart';
import 'curved_animation_factory.dart';

import '../cnotrol_bar.dart';
import '../settings.dart';

class ClothItemCompoundViewLayoutSwitcher extends StatefulWidget {
  final List<ClothItem> clothItems;
  final ClothItemCompoundViewLayout currentLayout;

  const ClothItemCompoundViewLayoutSwitcher({
    super.key,
    required this.clothItems,
    required this.currentLayout,
  });

  @override
  State<ClothItemCompoundViewLayoutSwitcher> createState() =>
      _ClothItemCompoundViewLayoutSwitcherState();
}

class _ClothItemCompoundViewLayoutSwitcherState
    extends State<ClothItemCompoundViewLayoutSwitcher>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _toListAnimation;
  late final Animation<double> _toGridAnimation;

  final _visibilitiesManager = _LayoutVisibilitiesManager();

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
      duration: layoutSwitchAnimationDuration,
    );
  }

  void _initLayoutVisibilatyUpdates() {
    _controller.addStatusListener(
      (_) => _visibilitiesManager.update(
        controller: _controller,
        layout: widget.currentLayout,
      ),
    );
  }

  void _initCurvedAnimations() {
    _toGridAnimation = LayoutSwitcherCurvedAnimationFactory(
      controller: _controller,
      curve: Curves.easeInQuart,
    ).animation();

    _toListAnimation = LayoutSwitcherCurvedAnimationFactory(
      controller: _controller,
      curve: Curves.easeOutQuart,
    ).animation();
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
        if (_visibilitiesManager.showGrid)
          _gridAnimatedLayoutFactory.animatedLayout(),
        if (_visibilitiesManager.showList)
          _listAnimatedLayoutFactory.animatedLayout(),
      ],
    );
  }

  void _runSwitchAnimation() {
    if (_layoutIsGrid) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  bool get _layoutIsGrid =>
      widget.currentLayout == ClothItemCompoundViewLayout.grid;

  ClothItemAnimatedLayoutFactory get _gridAnimatedLayoutFactory =>
      GridClothItemAnimatedLayoutFactory(
        controller: _controller,
        clothItems: widget.clothItems,
        currentAnimation: _currentAnimation,
        screenWidth: _screenWidth,
      );

  ClothItemAnimatedLayoutFactory get _listAnimatedLayoutFactory =>
      ListClothItemAnimatedLayoutFactory(
        controller: _controller,
        clothItems: widget.clothItems,
        currentAnimation: _currentAnimation,
        screenWidth: _screenWidth,
      );

  Animation<double> get _currentAnimation =>
      _layoutIsGrid ? _toGridAnimation : _toListAnimation;

  double get _screenWidth => MediaQuery.of(context).size.width;
}

class _LayoutVisibilitiesManager {
  bool _showGrid = true;
  bool _showList = true;

  bool get showGrid => _showGrid;
  bool get showList => _showList;

  void update({
    required AnimationController controller,
    required ClothItemCompoundViewLayout layout,
  }) {
    if (controller.isAnimating) {
      _showList = true;
      _showGrid = true;
    } else {
      _showGrid = _layoutIsGrid(layout);
      _showList = !_layoutIsGrid(layout);
    }
  }

  bool _layoutIsGrid(ClothItemCompoundViewLayout layout) =>
      layout == ClothItemCompoundViewLayout.grid;
}
