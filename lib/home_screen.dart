import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/dependancies/compound_view_manager_initialiser.dart';
import 'package:wardrobe_app/outfit/presentation/screens/list_screen.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/search_deligate.dart';

import 'cloth_item/presentation/shared_presenters/new_item_manager.dart';
import 'cloth_item/presentation/screens/editing_screen/editing_screen.dart';
import 'outfit/presentation/screens/maker_screen/maker_screen.dart';
import 'settings_screen/settings_screen.dart';
import 'cloth_item/presentation/screens/compound_view/compound_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _mainBody(),
      floatingActionButton: _floatingActionButton(context),
      bottomNavigationBar: _BottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text("wardrobe"),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => showSearch(
            context: context,
            delegate: ClothItemSearchDeligate(),
          ),
        )
      ],
    );
  }

  Widget _mainBody() {
    return FutureBuilder(
      future: ClothItemCompoundViewManagerinitialiser().assembleViewManager(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return ListenableBuilder(
            listenable: GetIt.I<ClothItemUiNotifier>(),
            builder: (_, __) {
              return ClothItemCompoundView(
                settingsManager: snapshot.data!,
                noItemsMessageText: "no items saved yet",
              );
            },
          );
        } else {
          return Container();
        }
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
          _settingsButton(context),
          _savedOutfitsButton(context),
          _newItemButton(context),
        ],
      ),
    );
  }

  Widget _settingsButton(BuildContext context) {
    return IconButton(
      tooltip: "settings",
      onPressed: () => _navigateTo(context, const SettingsScreen()),
      icon: const Icon(Icons.settings_outlined),
    );
  }

  Widget _savedOutfitsButton(BuildContext context) {
    return IconButton(
      onPressed: () => _navigateTo(context, const OutfitListScreen()),
      icon: const Icon(Icons.bookmark_outline),
    );
  }

  Widget _newItemButton(BuildContext context) {
    return IconButton(
      tooltip: "new item",
      onPressed: () => _navigateTo(
        context,
        ClothItemEditingScreen(
          editingManager: ClothItemEditingManager(),
        ),
      ),
      icon: const Icon(Icons.add),
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
