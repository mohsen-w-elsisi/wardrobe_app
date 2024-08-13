import 'package:flutter/foundation.dart';
import 'package:wardrobe_app/outfit/outfit.dart';

import 'manager.dart';

class MockOutfitStorageAgent implements OutfitStorageAgent {
  final Set<_LogMessage> _log = {};

  void _addLog(_LogMessage message) {
    _log.add(message);
    if (kDebugMode) {
      print(_log);
    }
  }

  @override
  void deletAllOutfits() {
    _addLog(const _LogMessage(_StorageEvent.deleteAll));
  }

  @override
  void deleteOutfit(Outfit outfit) {
    assert(!(outfit.isEphemiral));
    _addLog(_LogMessage(_StorageEvent.delete, outfit));
  }

  @override
  List<Outfit> get presavedOutfits => [];

  @override
  void saveOutfit(Outfit outfit) {
    assert(!(outfit.isEphemiral));
    _addLog(_LogMessage(_StorageEvent.save, outfit));
  }
}

class _LogMessage {
  final Outfit? outfit;
  final _StorageEvent event;

  const _LogMessage(this.event, [this.outfit]);

  @override
  String toString() {
    return "${event.name} $outfit";
  }
}

enum _StorageEvent { delete, deleteAll, save }
