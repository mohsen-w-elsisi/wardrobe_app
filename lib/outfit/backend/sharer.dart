import 'package:share_plus/share_plus.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';

class OutfitSharer {
  static const _fileExtension = "jpg";
  static const _shareText = "what do you think of this outfit";

  final Iterable<ClothItem> _clothItems;
  late final List<XFile> _files;
  late final List<String> _names;

  OutfitSharer(this._clothItems);

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
