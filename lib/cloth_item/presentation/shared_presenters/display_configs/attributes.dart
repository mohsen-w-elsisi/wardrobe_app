import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

enum ClothItemAttributeDisplayConfig {
  classic(ClothItemAttribute.classic, "classic", Icons.work_outline),
  onFasion(ClothItemAttribute.onFasion, "on fassion", Icons.star_border_sharp),
  sportive(ClothItemAttribute.sportive, "sporty", Icons.sports_basketball);

  const ClothItemAttributeDisplayConfig(this.attribute, this.name, this.icon);

  final ClothItemAttribute attribute;
  final String name;
  final IconData icon;

  factory ClothItemAttributeDisplayConfig.of(ClothItemAttribute attribute) {
    return ClothItemAttributeDisplayConfig.values.firstWhere(
      (config) => config.attribute == attribute,
    );
  }
}
