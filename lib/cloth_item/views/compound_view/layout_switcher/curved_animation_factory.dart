import 'package:flutter/material.dart';

class LayoutSwitcherCurvedAnimationFactory {
  final AnimationController controller;
  final Curve curve;

  const LayoutSwitcherCurvedAnimationFactory({
    required this.controller,
    required this.curve,
  });

  Animation<double> animation() {
    return Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );
  }
}
