import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';

const ClothItemAttributeDisplayOptions clothItemAttributeDisplayOptions = {
  ClothItemAttribute.classic: _ClothItemAttributeDisplayOption(
    name: "classic",
    icon: Icons.work_outline,
  ),
  ClothItemAttribute.onFasion: _ClothItemAttributeDisplayOption(
    name: "on fassion",
    icon: Icons.star_border_sharp,
  ),
  ClothItemAttribute.sportive: _ClothItemAttributeDisplayOption(
    name: "sporty",
    icon: Icons.sports_basketball,
  ),
};

typedef ClothItemAttributeDisplayOptions
    = Map<ClothItemAttribute, _ClothItemAttributeDisplayOption>;

class _ClothItemAttributeDisplayOption {
  final String name;
  final IconData icon;

  const _ClothItemAttributeDisplayOption({
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
