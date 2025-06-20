import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/compound_view/compound_view.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/compound_view/settings.dart';

class ClothItemSearchDeligate extends SearchDelegate<ClothItem> {
  late ClothItemCompoundViewManager _viewManager;

  ClothItemCompoundViewSettings _viewSettings =
      const ClothItemCompoundViewSettings(
    layout: ClothItemCompoundViewLayout.list,
  );

  ClothItemSearchDeligate() {
    _generateUpdatedViewManager();
  }

  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  Widget buildResults(BuildContext context) => _resultsWidget();

  @override
  Widget buildSuggestions(BuildContext context) => _resultsWidget();

  Widget _resultsWidget() {
    return FutureBuilder(
      future: _generateUpdatedViewManager(),
      builder: (_, __) => ClothItemCompoundView(
        settingsManager: _viewManager,
        noItemsMessageText: "no items found",
      ),
    );
  }

  Future<void> _generateUpdatedViewManager() async {
    _viewManager = ClothItemCompoundViewManager(
      clothItems: await _findItemsMatchingQuery(),
      settings: _viewSettings,
    );
    _viewManager.addListener(() => _viewSettings = _viewManager.settings);
  }

  Future<List<ClothItem>> _findItemsMatchingQuery() async {
    final allItems = await GetIt.I<ClothItemQuerier>().getAll();
    return [
      for (final item in allItems)
        if (item.name.contains(query)) item
    ];
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    final clearButton = IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () => query = "",
    );
    return [clearButton];
  }
}
