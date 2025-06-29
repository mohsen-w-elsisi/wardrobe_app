import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/shared/entities/season.dart';

const SeasonDisplayConfigs seasonDisplayConfigs = {
  Season.all: SeasonDisplayConfig(
    name: "All Seasons",
    icon: Icons.all_inclusive,
  ),
  Season.summer: SeasonDisplayConfig(
    name: "Summer",
    icon: Icons.wb_sunny,
  ),
  Season.winter: SeasonDisplayConfig(
    name: "Winter",
    icon: Icons.ac_unit,
  ),
};

typedef SeasonDisplayConfigs = Map<Season, SeasonDisplayConfig>;

class SeasonDisplayConfig {
  final String name;
  final IconData icon;

  const SeasonDisplayConfig({
    required this.name,
    required this.icon,
  });
}
