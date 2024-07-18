import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item.dart';
import 'package:rxdart/rxdart.dart';
import 'cloth_item_grid_view.dart';
import 'cloth_item_list_view.dart';

class ClothItemCompoundView extends StatelessWidget {
  final List<ClothItem> clothItems;

  final settingsController = ClothItemCompoundViewSettingsController(
    ClothItemCompoundViewSettings.defaultSettings(),
  );

  ClothItemCompoundView(this.clothItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ClothItemCompoundViewSettings>(
      stream: settingsController.stream,
      builder: (_, __) => Column(
        children: [
          ClothItemCompoundViewControlBar(settingsController),
          Expanded(
            child: settingsController.layoutIs(ClothItemCompoundViewLayout.grid)
                ? ClothItemGridView(clothItems)
                : ClothItemListView(clothItems),
          ),
        ],
      ),
    );
  }
}

class ClothItemCompoundViewControlBar extends StatelessWidget {
  final ClothItemCompoundViewSettingsController settingsController;

  const ClothItemCompoundViewControlBar(this.settingsController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "sort by ",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const Text("name"),
        const Spacer(),
        IconButton(
          onPressed: toggleLayout,
          icon: Icon(
            settingsController.layoutIs(ClothItemCompoundViewLayout.grid)
                ? Icons.grid_view
                : Icons.list,
          ),
        )
      ],
    );
  }

  void toggleLayout() => settingsController.setLayout(
        settingsController.layoutIs(ClothItemCompoundViewLayout.grid)
            ? ClothItemCompoundViewLayout.list
            : ClothItemCompoundViewLayout.grid,
      );
}

class ClothItemCompoundViewSettingsController {
  late final BehaviorSubject<ClothItemCompoundViewSettings> _behaviorSubject;
  final ClothItemCompoundViewSettings settings;

  ClothItemCompoundViewSettingsController(this.settings) {
    _behaviorSubject = BehaviorSubject.seeded(settings);
  }

  Stream<ClothItemCompoundViewSettings> get stream => _behaviorSubject.stream;

  void _updateStream() => _behaviorSubject.add(settings);

  void setLayout(ClothItemCompoundViewLayout layout) {
    settings.layout = layout;
    _updateStream();
  }

  void setSortMode(ClothItemCompoundViewSortMode sortMode) {
    settings.sortMode = sortMode;
    _updateStream();
  }

  bool layoutIs(ClothItemCompoundViewLayout testLayout) =>
      testLayout == settings.layout;

  bool sortModeIs(ClothItemCompoundViewSortMode testSortMode) =>
      testSortMode == settings.sortMode;
}

class ClothItemCompoundViewSettings {
  late ClothItemCompoundViewLayout layout;
  late ClothItemCompoundViewSortMode sortMode;

  ClothItemCompoundViewSettings({
    required this.layout,
    required this.sortMode,
  });

  ClothItemCompoundViewSettings.defaultSettings() {
    layout = ClothItemCompoundViewLayout.grid;
    sortMode = ClothItemCompoundViewSortMode.byName;
  }
}

enum ClothItemCompoundViewLayout { list, grid }

enum ClothItemCompoundViewSortMode { byName, byDateCreated }
