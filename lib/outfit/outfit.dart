import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';

@immutable
class Outfit {
  final String id;
  final List<ClothItem> _items;
  final String name;

  const Outfit({
    required List<ClothItem> items,
    required this.id,
    required this.name,
  }) : _items = items;

  const Outfit.ephemiral({
    required List<ClothItem> items,
  })  : _items = items,
        id = '',
        name = '';

  List<ClothItem> get items => List.unmodifiable(_items);

  bool hasSameId(Outfit outfit) => id == outfit.id;

  // since this cannot be saved without and id nor a name
  bool get isEphemiral => name == '' || id == '';

  Outfit copyWith({List<ClothItem>? items, String? name, String? id}) => Outfit(
        id: id ?? this.id,
        items: items ?? this.items,
        name: name ?? this.name,
      );
}
