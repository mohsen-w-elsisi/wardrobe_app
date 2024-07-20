import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item.dart';
import 'package:wardrobe_app/settings_screen.dart';
import 'cloth_item_views/cloth_item_views.dart';

final mockClothItems = [
  ClothItem(name: "AE blue", type: ClothItemType.top),
  ClothItem(
    name: "beige pants",
    type: ClothItemType.bottom,
    attributes: [ClothItemAttribute.sportive],
  ),
  ClothItem(
    name: "beige pants",
    type: ClothItemType.bottom,
    attributes: [ClothItemAttribute.classic, ClothItemAttribute.onFasion],
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("placeHolder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClothItemCompoundView(mockClothItems),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_outlined),
      ),
      bottomNavigationBar: const HomeScreenBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}

class HomeScreenBottomAppBar extends StatelessWidget {
  const HomeScreenBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(
            onPressed: () => _navigateTo(context, const SettingsScreen()),
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.checkroom_outlined),
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
