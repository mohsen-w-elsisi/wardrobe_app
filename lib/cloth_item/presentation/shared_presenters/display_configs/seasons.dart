import 'package:flutter/material.dart';
import 'package:wardrobe_app/shared/entities/season.dart';

enum SeasonDisplayConfig {
  summer(Season.summer, "Summer", Icons.wb_sunny),
  winter(Season.winter, "Winter", Icons.ac_unit),
  all(Season.all, "All Seasons", Icons.all_inclusive);

  const SeasonDisplayConfig(this.season, this.name, this.icon);

  final Season season;
  final String name;
  final IconData icon;

  factory SeasonDisplayConfig.of(Season season) {
    return SeasonDisplayConfig.values.firstWhere(
      (config) => config.season == season,
    );
  }
}
