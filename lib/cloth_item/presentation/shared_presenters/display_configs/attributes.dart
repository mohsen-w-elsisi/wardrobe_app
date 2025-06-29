import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

const ClothItemAttributeDisplayConfigs clothItemAttributeDisplayOptions = {
  ClothItemAttribute.classic: ClothItemAttributeDisplayConfig(
    name: "classic",
    icon: Icons.work_outline,
  ),
  ClothItemAttribute.onFasion: ClothItemAttributeDisplayConfig(
    name: "on fassion",
    icon: Icons.star_border_sharp,
  ),
  ClothItemAttribute.sportive: ClothItemAttributeDisplayConfig(
    name: "sporty",
    icon: Icons.sports_basketball,
  ),
};

typedef ClothItemAttributeDisplayConfigs
    = Map<ClothItemAttribute, ClothItemAttributeDisplayConfig>;

class ClothItemAttributeDisplayConfig {
  final String name;
  final IconData icon;

  const ClothItemAttributeDisplayConfig({
    required this.name,
    required this.icon,
  });
}

class BowTieIcon {
  BowTieIcon._();

  static const _kFontFam = 'BowTieIcon';
  static const String? _kFontPkg = null;

  static const IconData icon =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
