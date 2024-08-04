import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_screen.dart';
import 'package:wardrobe_app/cloth_item_grouped_list.dart';
import 'package:wardrobe_app/outfiting/outfit_maker_screen.dart';
import 'package:wardrobe_app/settings_screen.dart';
import 'cloth_item_views/cloth_item_views.dart';

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
          onTap: (clothItem) =>
              _openDetailScreenforClothItem(context, clothItem),
        ),
      ),
    );
  }

  void _openDetailScreenforClothItem(
      BuildContext context, ClothItem clothItem) {
    _navigateTo(
      context,
      ClothItemDetailScreen(
        clothItem.id,
        enableHeroImage: false,
      ),
    );
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
