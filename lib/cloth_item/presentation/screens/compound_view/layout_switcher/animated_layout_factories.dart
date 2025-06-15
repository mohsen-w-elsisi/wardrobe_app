import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/compound_view/layout_switcher/animated_layout.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/grid_view.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/list_view.dart';

class ListClothItemAnimatedLayoutFactory
    extends ClothItemAnimatedLayoutFactory {
  final Animation<double> _currentAnimation;
  final double _screenWidth;

  ListClothItemAnimatedLayoutFactory({
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

class GridClothItemAnimatedLayoutFactory
    extends ClothItemAnimatedLayoutFactory {
  final Animation<double> _currentAnimation;
  final double _screenWidth;

  GridClothItemAnimatedLayoutFactory({
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

abstract class ClothItemAnimatedLayoutFactory {
  final AnimationController controller;
  final List<ClothItem> clothItems;

  const ClothItemAnimatedLayoutFactory({
    required this.controller,
    required this.clothItems,
  });

  double _opacity();
  double _xPosition();

  Widget _buildLayout();

  ClothItemAnimatedLayout animatedLayout() => ClothItemAnimatedLayout(
      controller: controller,
      xPosition: _xPosition,
      opacity: _opacity,
      child: _buildLayout());
}
