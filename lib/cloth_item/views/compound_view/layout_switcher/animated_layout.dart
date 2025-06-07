import 'package:flutter/material.dart';

class ClothItemAnimatedLayout extends AnimatedWidget {
  const ClothItemAnimatedLayout({
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
