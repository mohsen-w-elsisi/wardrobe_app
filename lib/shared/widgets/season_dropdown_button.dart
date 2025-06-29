import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/seasons.dart';
import 'package:wardrobe_app/shared/entities/season.dart';

class SeasonDropdownButton extends StatefulWidget {
  final Season initalSeason;
  final void Function(Season) onSeasonSelected;

  const SeasonDropdownButton({
    super.key,
    required this.initalSeason,
    required this.onSeasonSelected,
  });

  @override
  State<SeasonDropdownButton> createState() => _SeasonDropdownButtonState();
}

class _SeasonDropdownButtonState extends State<SeasonDropdownButton> {
  late Season _season;

  @override
  void initState() {
    super.initState();
    _season = widget.initalSeason;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Season>(
      onChanged: _onSeasonSelect,
      value: _season,
      items: _menuItems,
    );
  }

  void _onSeasonSelect(Season? season) {
    setState(() {
      _season = season ?? Season.all;
    });
    widget.onSeasonSelected(_season);
  }

  List<DropdownMenuItem<Season>> get _menuItems {
    return [
      for (final season in Season.values)
        DropdownMenuItem<Season>(
          value: season,
          child: Row(
            children: [
              Icon(seasonDisplayConfigs[season]!.icon),
              const SizedBox(width: 8),
              Text(seasonDisplayConfigs[season]!.name),
            ],
          ),
        ),
    ];
  }
}
