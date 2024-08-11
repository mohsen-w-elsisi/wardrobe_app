import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'cloth_item/cloth_item.dart';
import 'cloth_item/manager.dart';
import 'cloth_item_editers/new_cloth_item_manager.dart';
import 'cloth_item_editers/new_cloth_item_screen.dart';
import 'cloth_item_views/grouped_list_view.dart';
import 'outfiting/outfit_maker_screen.dart';
import 'settings_screen/settings_screen.dart';
import 'cloth_item_views/compound_view/cloth_item_compound_view.dart';
import 'cloth_item_views/details_screen.dart';

class HomeScreen extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("wardrobe"),
        centerTitle: true,
      ),
      drawer: HomeScreenDrawer(),
      body: ListenableBuilder(
        listenable: clothItemManager,
        builder: (context, _) {
          return ClothItemCompoundView(clothItemManager.clothItems);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateTo(context, OutfitMakerScreen()),
        child: const Icon(Icons.checkroom_outlined),
      ),
      bottomNavigationBar: HomeScreenBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}

class HomeScreenDrawer extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();

  HomeScreenDrawer({super.key});

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

class HomeScreenBottomAppBar extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();

  HomeScreenBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(
            onPressed: () => _navigateTo(context, SettingsScreen()),
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            onPressed: () => _navigateTo(
              context,
              NewClothItemScreen(
                newClothItemManager: NewClothItemManager(),
              ),
            ),
            icon: const Icon(Icons.add),
          )
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
