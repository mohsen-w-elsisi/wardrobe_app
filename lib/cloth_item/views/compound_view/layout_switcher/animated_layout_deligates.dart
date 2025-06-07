import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/views/compound_view/layout_switcher/animated_layout.dart';
import 'package:wardrobe_app/cloth_item/views/grid_view.dart';
import 'package:wardrobe_app/cloth_item/views/list_view.dart';

class ListClothItemAnimatedLayoutDeligate
    extends ClothItemAnimatedLayoutDeligate {
  final Animation<double> _currentAnimation;
  final double _screenWidth;

  ListClothItemAnimatedLayoutDeligate({
    required super.controller,
    required super.clothItems,
    required Animation<double> currentAnimation,
    required double screenWidth,
  })  : _currentAnimation = currentAnimation,
        _screenWidth = screenWidth;

  @override
  double _opacity() => _currentAnimation.value;

  @override
  double _xPosition() =>
      _screenWidth - (_currentAnimation.value * _screenWidth);

  @override
  Widget _buildLayout() {
    return ClothItemListView(
      clothItems,
      nonScrollable: true,
      key: const Key("list layout"),
    );
  }
}

class GridClothItemAnimatedLayoutDeligate
    extends ClothItemAnimatedLayoutDeligate {
  final Animation<double> _currentAnimation;
  final double _screenWidth;

  GridClothItemAnimatedLayoutDeligate({
    required super.controller,
    required super.clothItems,
    required Animation<double> currentAnimation,
    required double screenWidth,
  })  : _currentAnimation = currentAnimation,
        _screenWidth = screenWidth;

  @override
  double _opacity() => 1 - _currentAnimation.value;

  @override
  double _xPosition() => -(_currentAnimation.value * _screenWidth);

  @override
  Widget _buildLayout() {
    return ClothItemGridView(
      clothItems,
      nonScrollable: true,
      key: const Key("grid layout"),
    );
  }
}

abstract class ClothItemAnimatedLayoutDeligate {
  final AnimationController controller;
  final List<ClothItem> clothItems;

  const ClothItemAnimatedLayoutDeligate({
    required this.controller,
    required this.clothItems,
  });

  double _opacity();
  double _xPosition();

  Widget _buildLayout();

  ClothItemAnimatedLayout buildAnimatedLayout() => ClothItemAnimatedLayout(
      controller: controller,
      layout: _buildLayout(),
      xPosition: _xPosition,
      opacity: _opacity);
}
