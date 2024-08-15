import 'package:hive/hive.dart';
import 'package:wardrobe_app/outfit/manager.dart';

import 'outfit.dart';

class HiveOutfitStorageAgent implements OutfitStorageAgent {
  static const _boxName = "outfits";

  late final Box<Outfit> _box;

  Future<void> initialise() async {
    Hive.registerAdapter(OutfitAdapter());
    _box = await Hive.openBox<Outfit>(_boxName);
  }

  @override
  void deletAllOutfits() {
    _box.clear();
  }

  @override
  void deleteOutfit(Outfit outfit) {
    _assertExists(outfit);
    _box.delete(outfit.id);
  }

  @override
  void saveOutfit(Outfit outfit) {
    _assertNonEphemiral(outfit);
    _box.put(outfit.id, outfit);
  }

  @override
  List<Outfit> get presavedOutfits => _outfits;

  void _assertNonEphemiral(Outfit outfit) {
    assert(!(outfit.isEphemiral));
  }

  void _assertExists(Outfit outfit) {
    assert(_box.containsKey(outfit.id));
  }

  List<Outfit> get _outfits => _box.values.toList();
}
