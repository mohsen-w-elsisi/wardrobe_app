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
      duration: layoutSwitchAnimationDuration,
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
        if (_showGrid) _gridAnimatedLayoutDeligate.buildAnimatedLayout(),
        if (_showList) _listAnimatedLayoutDeligate.buildAnimatedLayout(),
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

  ClothItemAnimatedLayoutDeligate get _gridAnimatedLayoutDeligate =>
      GridClothItemAnimatedLayoutDeligate(
        controller: _controller,
        clothItems: widget.clothItems,
        currentAnimation: _currentAnimation,
        screenWidth: _screenWidth,
      );

  ClothItemAnimatedLayoutDeligate get _listAnimatedLayoutDeligate =>
      ListClothItemAnimatedLayoutDeligate(
        controller: _controller,
        clothItems: widget.clothItems,
        currentAnimation: _currentAnimation,
        screenWidth: _screenWidth,
      );

  Animation<double> get _currentAnimation =>
      _layoutIsGrid ? _toGridAnimation : _toListAnimation;

  double get _screenWidth => MediaQuery.of(context).size.width;
}
