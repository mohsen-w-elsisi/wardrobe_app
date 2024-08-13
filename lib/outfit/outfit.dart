import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';

@immutable
class Outfit {
  final List<ClothItem> _items;
  final String? name;

  const Outfit({
    required List<ClothItem> items,
    this.name,
  }) : _items = items;

  List<ClothItem> get items => List.unmodifiable(_items);
}
