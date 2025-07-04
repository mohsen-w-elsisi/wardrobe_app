import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/editing_screen/image/image_selecter.dart';

class ClothItemImageSelectionModal extends StatelessWidget {
  final ClothItemEditingManager editingManager;
  final Function()? onSelect;

  const ClothItemImageSelectionModal({
    required this.editingManager,
    this.onSelect,
    super.key,
  });

  void show(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(context),
        ..._imageSourceTiles(context),
      ],
    );
  }

  Padding _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 12),
      child: Text(
        "take image from",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  List<Widget> _imageSourceTiles(BuildContext context) => [
        for (final source in ImageSource.values)
          ListTile(
            onTap: () => _onSourceSelect(context, source),
            title: Text(source.name),
          )
      ];

  Future<void> _onSourceSelect(BuildContext context, ImageSource source) async {
    Navigator.pop(context);
    await _savedPickedImage(source);
    if (onSelect != null) onSelect!();
  }

  Future<void> _savedPickedImage(ImageSource source) async {
    final imageBytes = await ImageSelecter(source: source).pickImage();
    if (imageBytes != null) {
      editingManager.image = imageBytes;
    }
  }
}
