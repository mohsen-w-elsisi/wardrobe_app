import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_editers/cloth_item_matching_dialog.dart';
import 'package:wardrobe_app/cloth_item_editers/image_source_selector_modal.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_image.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_type_display_options.dart';
import 'new_cloth_item_manager.dart';

class NewClothItemScreen extends StatelessWidget {
  final NewClothItemManager newClothItemManager;
  final bool showMatchingsDialog;

  const NewClothItemScreen({
    required this.newClothItemManager,
    this.showMatchingsDialog = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _PhotoSelector(newClothItemManager: newClothItemManager),
            _NameField(newClothItemManager: newClothItemManager),
            _TypeSelector(newClothItemManager: newClothItemManager),
            _AttributeSelector(newClothItemManager: newClothItemManager),
            const Spacer(),
            _NextStepButton(
              newClothItemManager: newClothItemManager,
              showMatchingsDialog: showMatchingsDialog,
            )
          ],
        ),
      ),
    );
  }
}

class _PhotoSelector extends StatelessWidget {
  final NewClothItemManager newClothItemManager;

  const _PhotoSelector({
    required this.newClothItemManager,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => GestureDetector(
        onTap: () => _showImageSourceOptions(context, setState),
        child: newClothItemManager.image.isEmpty
            ? _blankImageSelector(context)
            : _filledImageSelector(),
      ),
    );
  }

  void _showImageSourceOptions(BuildContext context, StateSetter setState) {
    ImageSelectorModal(
      newClothItemManager: newClothItemManager,
      onSelect: () => setState(() {}),
    ).show(context);
  }

  Widget _blankImageSelector(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).colorScheme.secondaryFixedDim,
        ),
        child: const Center(
          child: Icon(Icons.camera_alt, size: 48),
        ),
      ),
    );
  }

  Widget _filledImageSelector() => Hero(
        tag: newClothItemManager.id ?? "",
        child: ClothItemImage(image: newClothItemManager.image),
      );
}

class _NameField extends StatefulWidget {
  final NewClothItemManager newClothItemManager;

  const _NameField({required this.newClothItemManager, super.key});

  @override
  State<_NameField> createState() => _NameFieldState();
}

class _TypeSelector extends StatelessWidget {
  final NewClothItemManager newClothItemManager;

  const _TypeSelector({
    required this.newClothItemManager,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      child: StatefulBuilder(
        builder: (context, setState) => SegmentedButton(
          selected: {newClothItemManager.type},
          onSelectionChanged: (p0) => setState(
            () => newClothItemManager.type = p0.single,
          ),
          segments: [
            for (final type in ClothItemType.values)
              ButtonSegment(
                value: type,
                label: Text(clothItemTypeDisplayOptions[type]!.text),
              )
          ],
        ),
      ),
    );
  }
}

class _AttributeSelector extends StatelessWidget {
  const _AttributeSelector({
    super.key,
    required this.newClothItemManager,
  });

  final NewClothItemManager newClothItemManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      child: StatefulBuilder(
        builder: (context, setState) => SegmentedButton(
          multiSelectionEnabled: true,
          emptySelectionAllowed: true,
          showSelectedIcon: false,
          selected: newClothItemManager.attributes.toSet(),
          onSelectionChanged: (p0) => setState(
            () => newClothItemManager.attributes = p0.toList(),
          ),
          segments: [
            for (final attribute in ClothItemAttribute.values)
              ButtonSegment(
                value: attribute,
                label: Text(attribute.name),
              )
          ],
        ),
      ),
    );
  }
}

class _NameFieldState extends State<_NameField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.newClothItemManager.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (text) => widget.newClothItemManager.name = text,
    );
  }
}

class _NextStepButton extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final NewClothItemManager newClothItemManager;
  final bool showMatchingsDialog;

  _NextStepButton({
    required this.newClothItemManager,
    this.showMatchingsDialog = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: FilledButton(
        onPressed: () => (showMatchingsDialog
            ? _showItemMatchingDialog
            : _saveItem)(context),
        child: const Text("next"),
      ),
    );
  }

  void _showItemMatchingDialog(BuildContext context) {
    ClothItemMatchingDialog(
      newClothItemManager: newClothItemManager,
      onDismiss: _saveItem,
    ).show(context);
  }

  void _saveItem(BuildContext context) {
    clothItemManager.saveItem(newClothItemManager.clothItem);
    Navigator.pop(context);
  }
}
