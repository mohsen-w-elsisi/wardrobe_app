import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/settings_screen.dart';
import 'cloth_item_views/cloth_item_views.dart';

final mockClothItems = [
  ClothItem(name: "AE blue", type: ClothItemType.top, id: "1"),
  ClothItem(
    name: "beige pants",
    id: "2",
    type: ClothItemType.bottom,
    attributes: [ClothItemAttribute.sportive],
  ),
  ClothItem(
    name: "beige pants",
    type: ClothItemType.bottom,
    attributes: [ClothItemAttribute.classic, ClothItemAttribute.onFasion],
    matchingItems: ["1", "2"],
  ),
];

class HomeScreen extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("placeHolder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<ClothItem>>(
          stream: clothItemManager.stream,
          builder: (context, snapshot) {
            return ClothItemCompoundView(clothItemManager.clothItems);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.checkroom_outlined),
      ),
      bottomNavigationBar: HomeScreenBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
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
            onPressed: () => clothItemManager.saveNewItem(
              ClothItem(name: "AE blue", type: ClothItemType.top, id: "1"),
            ),
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }
}
