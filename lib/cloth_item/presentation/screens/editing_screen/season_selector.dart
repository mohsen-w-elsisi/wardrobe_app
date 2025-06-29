import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/new_item_manager.dart';
import 'package:wardrobe_app/shared/widgets/season_dropdown_button.dart';

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
        Text("season:", style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(width: 8),
        SeasonDropdownButton(
          initalSeason: editingManager.season,
          onSeasonSelected: _updateEditingManagerSeason,
        ),
      ],
    );
  }

  void _updateEditingManagerSeason(season) => editingManager.season = season;
}
