import 'package:flutter/material.dart';

@immutable
class Outfit {
  final String id;
  final List<String> _items;
  final String name;

  const Outfit({
    required List<String> items,
    required this.id,
    required this.name,
  }) : _items = items;

  const Outfit.ephemiral({
    required List<String> items,
  })  : _items = items,
        id = '',
        name = '';

  List<String> get items => List.unmodifiable(_items);

  bool hasSameId(Outfit outfit) => id == outfit.id;

  // since this cannot be saved without an id nor a name
  bool get isEphemiral => name == '' || id == '';

  Outfit copyWith({List<String>? items, String? name, String? id}) => Outfit(
        id: id ?? this.id,
        items: items ?? this.items,
        name: name ?? this.name,
      );
}
