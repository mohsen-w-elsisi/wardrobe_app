import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';
import 'package:wardrobe_app/cloth_item/views/matching_dialog.dart';
import '../../../backend/new_item_manager.dart';
import 'attribute_selector.dart';
import 'name_field.dart';
import 'photo_selector.dart';
import 'type_selector.dart';

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
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: _bodyHeight(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: _editingComponents,
              ),
            ),
          ),
        );
      }),
    );
  }

  double _bodyHeight(BuildContext context) {
    final screenHieght = MediaQuery.of(context).size.height;
    final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
    return screenHieght - appBarHeight;
  }

  List<Widget> get _editingComponents => [
        NewClothItemPhotoSelector(newClothItemManager: newClothItemManager),
        NewClothItemNameField(newClothItemManager: newClothItemManager),
        NewClothItemScreenTypeSelector(
            newClothItemManager: newClothItemManager),
        NewClothItemScreenAttributeSelector(
            newClothItemManager: newClothItemManager),
        const Spacer(),
        _NextStepButton(
          newClothItemManager: newClothItemManager,
          showMatchingsDialog: showMatchingsDialog,
        ),
      ];
}

class _NextStepButton extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final NewClothItemManager newClothItemManager;
  final bool showMatchingsDialog;

  _NextStepButton({
    required this.newClothItemManager,
    this.showMatchingsDialog = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: FilledButton(
        onPressed: () => _onTap(context),
        child: const Text("next"),
      ),
    );
  }

  Function get _onTap => showMatchingsDialog
      ? _showItemMatchingDialogOrMissingInputSnacknbar
      : _saveItemOrShowMissingInputDialog;

  void _showItemMatchingDialogOrMissingInputSnacknbar(BuildContext context) {
    if (newClothItemManager.requiredFieldsSet) {
      _showItemMatchingDialog(context);
    } else {
      _showMissingInputSnackbar(context);
    }
  }

  void _saveItemOrShowMissingInputDialog(BuildContext context) {
    if (newClothItemManager.requiredFieldsSet) {
      _saveItem(context);
    } else {
      _showMissingInputSnackbar(context);
    }
  }

  void _showMissingInputSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("you must enter a name and a photo")),
    );
  }

  void _showItemMatchingDialog(BuildContext context) {
    ClothItemMatchingDialog(
      newClothItemManager: newClothItemManager,
      onDismiss: _saveItem,
      clothItem: newClothItemManager.clothItem,
    ).show(context);
  }

  void _saveItem(BuildContext context) {
    clothItemManager.saveItem(newClothItemManager.clothItem);
    Navigator.pop(context);
  }
}
