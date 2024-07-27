import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_editers/cloth_item_matching_dialog.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views_utils.dart';
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
            NewClothItemNameField(newClothItemManager: newClothItemManager),
            NewClothItemTypeSelector(newClothItemManager: newClothItemManager),
            NewClothItemAttributeSelector(
                newClothItemManager: newClothItemManager),
            const Spacer(),
            NewClothItemNextStepButton(
              newClothItemManager: newClothItemManager,
              showMatchingsDialog: showMatchingsDialog,
            )
          ],
        ),
      ),
    );
  }
}

class NewClothItemNextStepButton extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final NewClothItemManager newClothItemManager;
  final bool showMatchingsDialog;

  NewClothItemNextStepButton({
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
    showDialog(
      context: context,
      builder: (context) => ClothItemMatchingDialog(
        newClothItemManager: newClothItemManager,
        onDismiss: _saveItem,
      ),
    );
  }

  void _saveItem(BuildContext context) {
    clothItemManager.saveItem(newClothItemManager.clothItem);
    Navigator.pop(context);
  }
}

class NewClothItemAttributeSelector extends StatelessWidget {
  const NewClothItemAttributeSelector({
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

class NewClothItemTypeSelector extends StatelessWidget {
  final NewClothItemManager newClothItemManager;

  const NewClothItemTypeSelector({
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
                label: Text(clothTypeTextMap[type]!),
              )
          ],
        ),
      ),
    );
  }
}

class NewClothItemNameField extends StatefulWidget {
  final NewClothItemManager newClothItemManager;

  const NewClothItemNameField({required this.newClothItemManager, super.key});

  @override
  State<NewClothItemNameField> createState() => _NewClothItemNameFieldState();
}

class _NewClothItemNameFieldState extends State<NewClothItemNameField> {
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
