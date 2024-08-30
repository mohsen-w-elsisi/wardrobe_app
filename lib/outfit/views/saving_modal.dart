import 'package:flutter/material.dart';
import 'package:wardrobe_app/subbmitable_bottom_sheet.dart';

import '../backend/outfit_saver.dart';

class OutfitSavingDialog extends StatelessWidget {
  final OutfitSaver outfitSaver;
  final void Function() onSubmit;

  const OutfitSavingDialog({
    super.key,
    required this.onSubmit,
    required this.outfitSaver,
  });

  void show(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => this);
  }

  @override
  Widget build(BuildContext context) {
    return SubmitableBottomSheet(
      title: "save outfit",
      submitButtonText: "save",
      onSubmit: _saveOutfit,
      context: context,
      builder: (_) => _nameTextField(),
    );
  }

  Widget _nameTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: true,
        decoration: const InputDecoration(labelText: "outfit name"),
        onChanged: outfitSaver.updateName,
      ),
    );
  }

  void _saveOutfit() {
    outfitSaver.save();
    onSubmit();
  }
}
