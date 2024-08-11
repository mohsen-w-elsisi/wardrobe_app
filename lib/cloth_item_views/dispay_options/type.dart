import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';

const ClothItemTypeDisplayOptions clothItemTypeDisplayOptions = {
  ClothItemType.top: ClothItemTypeDisplayOption(
    text: "top",
    icon: Icons.topic,
  ),
  ClothItemType.bottom: ClothItemTypeDisplayOption(
    text: "leg ware",
    icon: Icons.luggage,
  ),
  ClothItemType.jacket: ClothItemTypeDisplayOption(
    text: "jacket",
    icon: Icons.offline_bolt,
  ),
};

typedef ClothItemTypeDisplayOptions
    = Map<ClothItemType, ClothItemTypeDisplayOption>;

class ClothItemTypeDisplayOption<T extends ClothItemType> {
  final String text;
  final IconData icon;

  const ClothItemTypeDisplayOption({required this.text, required this.icon});
}
