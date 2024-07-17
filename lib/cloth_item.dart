class ClothItem {
  late final String id;
  late final DateTime dateCreated;

  String name;
  ClothItemType type;
  bool isFavourite;
  List<ClothItemAttribute> attributes;

  List<String> matchingItems = [];

  ClothItem({
    required this.name,
    required this.type,
    this.isFavourite = false,
    this.attributes = const [],
  }) {
    dateCreated = DateTime.now();
    id = dateCreated.toIso8601String();
  }
}

enum ClothItemType { top, bottom, jacket }

enum ClothItemAttribute { sportive, onFasion, classic }
