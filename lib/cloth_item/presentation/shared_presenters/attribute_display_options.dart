import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

const ClothItemAttributeDisplayOptions clothItemAttributeDisplayOptions = {
  ClothItemAttribute.classic: ClothItemAttributeDisplayOption(
    name: "classic",
    icon: Icons.work_outline,
  ),
  ClothItemAttribute.onFasion: ClothItemAttributeDisplayOption(
    name: "on fassion",
    icon: Icons.star_border_sharp,
  ),
  ClothItemAttribute.sportive: ClothItemAttributeDisplayOption(
    name: "sporty",
    icon: Icons.sports_basketball,
  ),
};

typedef ClothItemAttributeDisplayOptions
    = Map<ClothItemAttribute, ClothItemAttributeDisplayOption>;

class ClothItemAttributeDisplayOption {
  final String name;
  final IconData icon;

  const ClothItemAttributeDisplayOption({
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
