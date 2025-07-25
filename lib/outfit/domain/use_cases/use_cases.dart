import 'package:wardrobe_app/outfit/domain/outfit.dart';

abstract class OutfitQuerier {
  Outfit getById(String id);
  Iterable<Outfit> getAll();
  Future<Iterable<Outfit>> getAllOfCurrentSeason();
  bool outfitExists(Outfit outfit);
}

abstract class OutfitSaver {
  void save(Outfit outfit);
}

abstract class OutfitDeleter {
  void delete(Outfit outfit);
}

abstract class OutfitSharer {
  void share(Outfit outfit);
}
