import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/views/grid_view.dart';
import 'package:wardrobe_app/cloth_item/views/list_view.dart';

import 'settings.dart';

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
