import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/outfit/domain/outfit.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/use_cases.dart';

class OutfitEditingManager {
  Outfit _outfit;

  OutfitEditingManager({required Outfit outfit}) : _outfit = outfit;

  void updateName(String name) {
    _outfit = _outfit.copyWith(name: name);
  }

  void save() {
    _assingId();
    GetIt.I<OutfitSaver>().save(_outfit);
  }

  void _assingId() {
    _outfit = _outfit.copyWith(
      id: DateTime.now().toIso8601String(),
    );
  }

  Outfit get outfit => _outfit;
}
