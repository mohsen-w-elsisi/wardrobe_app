import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/outfit/backend/manager.dart';
import 'package:wardrobe_app/outfit/backend/outfit.dart';

class OutfitSaver {
  final _outfitManager = GetIt.I.get<OutfitManager>();
  Outfit _outfit;

  OutfitSaver({required Outfit outfit}) : _outfit = outfit;

  void updateName(String name) {
    _outfit = _outfit.copyWith(name: name);
  }

  void save() {
    _assingId();
    _outfitManager.saveOutfit(_outfit);
  }

  void _assingId() {
    _outfit = _outfit.copyWith(
      id: DateTime.now().toIso8601String(),
    );
  }

  Outfit get outfit => _outfit;
}
