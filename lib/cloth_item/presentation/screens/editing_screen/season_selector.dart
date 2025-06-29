import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/seasons.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/new_item_manager.dart';

class CkithItemSeasonSelector extends StatelessWidget {
  final ClothItemEditingManager editingManager;

  const CkithItemSeasonSelector({
    required this.editingManager,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            "season:",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        _SeasonDropdown(editingManager: editingManager)
      ],
    );
  }
}

class _SeasonDropdown extends StatefulWidget {
  final ClothItemEditingManager editingManager;

  const _SeasonDropdown({
    required this.editingManager,
  });

  @override
  State<_SeasonDropdown> createState() => _SeasonDropdownState();
}

class _SeasonDropdownState extends State<_SeasonDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Season>(
      onChanged: _onSeasonSelect,
      value: widget.editingManager.season,
      items: _menuItems,
    );
  }

  void _onSeasonSelect(Season? season) {
    setState(() {
      if (season != null) {
        widget.editingManager.season = season;
      } else {
        widget.editingManager.season = Season.all;
      }
    });
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
