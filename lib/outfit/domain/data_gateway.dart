import 'package:wardrobe_app/outfit/domain/outfit.dart';

abstract class OutfitDataGateway {
  List<Outfit> get presavedOutfits;
  Iterable<Outfit> getAll();
  Outfit getById(String id);
  bool outfitIsSaved(Outfit outfit);
  void saveOutfit(Outfit outfit);
  void delete(Outfit outfit);
  void deletAll();
}
