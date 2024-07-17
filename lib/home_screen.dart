import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views.dart';

final mockClothItems = [
  ClothItem(name: "AE blue", type: ClothItemType.top),
  ClothItem(name: "beige pants", type: ClothItemType.bottom),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
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
}
