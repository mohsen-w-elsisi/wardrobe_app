import 'package:hive/hive.dart';
import 'package:wardrobe_app/outfit/domain/data_gateway.dart';

import '../domain/outfit.dart';

class HiveOutfitDataGateway implements OutfitDataGateway {
  static const _boxName = "outfits";

  late final Box<Outfit> _box;

  Future<void> initialise() async {
    Hive.registerAdapter(OutfitAdapter());
    _box = await Hive.openBox<Outfit>(_boxName);
  }

  @override
  void deletAll() {
    _box.clear();
  }

  @override
  void delete(Outfit outfit) {
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

  @override
  Iterable<Outfit> getAll() {
    return _outfits;
  }

  @override
  Outfit getById(String id) {
    return _box.get(id) ?? (throw StateError('Outfit with id $id not found.'));
  }

  @override
  bool outfitIsSaved(Outfit outfit) {
    _assertNonEphemiral(outfit);
    return _box.containsKey(outfit.id);
  }
}
