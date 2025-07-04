import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/seasons.dart';
import 'package:wardrobe_app/shared/entities/season.dart';

class SeasonIcon extends StatelessWidget {
  final Season season;
  final bool hideAllSeasons;

  const SeasonIcon(
    this.season, {
    super.key,
    this.hideAllSeasons = false,
  });

  @override
  Widget build(BuildContext context) {
    if (hideAllSeasons && season == Season.all) {
      return Container();
    } else {
      return Icon(_icon);
    }
  }

  IconData get _icon => SeasonDisplayConfig.of(season).icon;
}
