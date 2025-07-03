import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'outfit.g.dart';

@HiveType(typeId: 4)
@immutable
class Outfit {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Iterable<String> items;
  @HiveField(2)
  final String name;

  const Outfit({
    required this.items,
    required this.id,
    required this.name,
  });

  const Outfit.ephemiral({
    required this.items,
  })  : id = '',
        name = '';

  bool hasSameId(Outfit outfit) => id == outfit.id;

  // since this cannot be saved without an id nor a name
  bool get isEphemiral => name == '' || id == '';

  Outfit copyWith({List<String>? items, String? name, String? id}) => Outfit(
        id: id ?? this.id,
        items: items ?? this.items,
        name: name ?? this.name,
      );
}
