import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wardrobe_app/cloth_item/domain/data_gateway.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/outfit/domain/outfit.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/use_cases.dart';

class OutfitSharerImpl extends OutfitSharer {
  @override
  Future<void> share(Outfit outfit) async {
    final items = await _itemsFromIds(outfit.items);
    _Sharer(items).share();
  }

  Future<List<ClothItem>> _itemsFromIds(Iterable<String> ids) async {
    return [
      for (final id in ids) await GetIt.I<ClothItemDataGateway>().getById(id),
    ];
  }
}

class _Sharer {
  static const _fileExtension = "jpg";
  static const _shareText = "what do you think of this outfit";

  final Iterable<ClothItem> _clothItems;
  late final List<XFile> _files;
  late final List<String> _names;

  _Sharer(this._clothItems);

  void share() {
    _generateFiles();
    _generateNames();
    _triggerShareModal();
  }

  void _generateFiles() {
    _files = [
      for (final item in _clothItems) XFile.fromData(item.image),
    ];
  }

  void _generateNames() {
    _names = [
      for (final item in _clothItems) "${item.name}.$_fileExtension",
    ];
  }

  void _triggerShareModal() {
    Share.shareXFiles(
      _files,
      text: _shareText,
      fileNameOverrides: _names,
    );
  }
}
