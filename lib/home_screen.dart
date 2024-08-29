import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/views/compound_view/settings.dart';
import 'package:wardrobe_app/outfit/views/list_screen.dart';

import 'cloth_item/backend/cloth_item.dart';
import 'cloth_item/backend/manager.dart';
import 'cloth_item/backend/new_item_manager.dart';
import 'cloth_item/views/editing_screen/new_screen/editing_screen.dart';
import 'cloth_item/views/grouped_list_view.dart';
import 'outfit/views/maker_screen/maker_screen.dart';
import 'settings_screen/settings_screen.dart';
import 'cloth_item/views/compound_view/compound_view.dart';
import 'cloth_item/views/details_screen.dart';

class HomeScreen extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: _Drawer(),
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
    final compoundViewManager = GetIt.I.get<ClothItemCompoundViewManager>();
    return ListenableBuilder(
      listenable: clothItemManager,
      builder: (_, __) => ClothItemCompoundView(compoundViewManager),
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

class _Drawer extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ClothItemGroupedList(
          clothItems: clothItemManager.clothItems,
          onTap: (clothItem) => _onItemTileTap(context, clothItem),
        ),
      ),
    );
  }

  void _onItemTileTap(BuildContext context, ClothItem clothItem) {
    _closeDrawer(context);
    _openDetailScreenforClothItem(context, clothItem);
  }

  void _openDetailScreenforClothItem(
      BuildContext context, ClothItem clothItem) {
    _navigateTo(
      context,
      ClothItemDetailScreen(clothItem.id, enableHeroImage: false),
    );
  }

  void _closeDrawer(BuildContext context) {
    Scaffold.of(context).closeDrawer();
  }
}

class _BottomAppBar extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(
            tooltip: "settings",
            onPressed: () => _navigateTo(context, SettingsScreen()),
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
              NewClothItemScreen(
                newClothItemManager: NewClothItemManager(),
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
