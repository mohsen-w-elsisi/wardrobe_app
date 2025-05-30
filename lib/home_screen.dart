import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';
import 'package:wardrobe_app/dependancies/compound_view_manager_initialiser.dart';
import 'package:wardrobe_app/outfit/views/list_screen.dart';

import 'cloth_item/presenters/new_item_manager.dart';
import 'cloth_item/views/editing_screen/editing_screen.dart';
import 'outfit/views/maker_screen/maker_screen.dart';
import 'settings_screen/settings_screen.dart';
import 'cloth_item/views/compound_view/compound_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _mainBody(),
      floatingActionButton: _floatingActionButton(context),
      bottomNavigationBar: _BottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("wardrobe"),
      centerTitle: true,
    );
  }

  Widget _mainBody() {
    final compoundViewManager =
        ClothItemCompoundViewManagerinitialiser().assembleViewManager();
    return ListenableBuilder(
      listenable: GetIt.I<ClothItemUiNotifier>(),
      builder: (_, __) {
        return ClothItemCompoundView(compoundViewManager);
      },
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      tooltip: "new outfit",
      onPressed: () => _navigateTo(context, OutfitMakerScreen()),
      child: const Icon(Icons.checkroom_outlined),
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(
            tooltip: "settings",
            onPressed: () => _navigateTo(context, const SettingsScreen()),
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            onPressed: () => _navigateTo(context, const OutfitListScreen()),
            icon: const Icon(Icons.bookmark_outline),
          ),
          IconButton(
            tooltip: "new item",
            onPressed: () => _navigateTo(
              context,
              ClothItemEditingScreen(
                editingManager: ClothItemEditingManager(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

void _navigateTo(BuildContext context, Widget screen) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => screen,
    ),
  );
}
