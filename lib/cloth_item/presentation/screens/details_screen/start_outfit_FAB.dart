import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/outfit/presentation/screens/maker_screen/maker_screen.dart';

class ClothItemDetailScreenStartOutfitFAB extends StatelessWidget {
  final ClothItem clothItem;

  const ClothItemDetailScreenStartOutfitFAB({
    required this.clothItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "new outfit with this",
      onPressed: () => _openOutfitMaker(context),
      child: const Icon(Icons.checkroom_outlined),
    );
  }

  void _openOutfitMaker(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OutfitMakerScreen(
          preSelectedItems: [clothItem],
        ),
      ),
    );
  }
}
