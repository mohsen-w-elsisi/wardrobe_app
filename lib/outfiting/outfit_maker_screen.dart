import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/manager.dart';
import 'package:wardrobe_app/outfiting/outfit_maker_manager.dart';

import 'outfit_maker_stepper.dart';

class OutfitMakerScreen extends StatelessWidget {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();
  final _outfitMakerManager = OutfitMakerManager();

  OutfitMakerScreen({List<ClothItem>? preSelectedItems, super.key}) {
    if (preSelectedItems != null) {
      preSelectedItems.forEach(_outfitMakerManager.setSelectedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("outfit maker"),
      ),
      body: ListenableBuilder(
        listenable: _clothItemManager,
        builder: (_, __) => OutfitMakerStepper(
          outfitMakerManager: _outfitMakerManager,
        ),
      ),
    );
  }
}
