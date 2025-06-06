import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/views/list_view.dart';

class ClothItemSearchDeligate extends SearchDelegate<ClothItem> {
  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  Widget buildResults(BuildContext context) => _resultsWidget();

  @override
  Widget buildSuggestions(BuildContext context) => _resultsWidget();

  Widget _resultsWidget() {
    return ClothItemListView(
      _findItemsMatchingQuery(),
    );
  }

  List<ClothItem> _findItemsMatchingQuery() {
    final allItems = GetIt.I<ClothItemQuerier>().getAll();
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
