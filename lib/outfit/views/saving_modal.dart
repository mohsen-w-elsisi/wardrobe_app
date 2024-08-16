import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/outfit/backend/manager.dart';
import 'package:wardrobe_app/outfit/backend/outfit.dart';
import 'package:wardrobe_app/outfit/views/presenter_screen.dart';
import 'package:wardrobe_app/subbmitable_bottom_sheet.dart';

class OutfitSavingDialog extends StatefulWidget {
  final Outfit outfit;

  const OutfitSavingDialog({super.key, required this.outfit});

  void show(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => this);
  }

  @override
  State<OutfitSavingDialog> createState() => _OutfitSavingDialogState();
}

class _OutfitSavingDialogState extends State<OutfitSavingDialog> {
  late final _OutfitSaver _outfitSaver;

  @override
  void initState() {
    super.initState();
    _initOutfitSaver();
  }

  void _initOutfitSaver() {
    _outfitSaver = _OutfitSaver(outfit: widget.outfit);
  }

  @override
  Widget build(BuildContext context) {
    return SubbmitableBottomSheet(
      title: "save outfit",
      submitButtonText: "save",
      onSubmit: () => _saveOutfit(context),
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
        onChanged: _outfitSaver.updateName,
      ),
    );
  }

  void _saveOutfit(BuildContext context) {
    _outfitSaver.save();
    _popAllScreensAndOpenOutfitPresenter(context);
  }

  void _popAllScreensAndOpenOutfitPresenter(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      _savedOutfitRoute,
      _routeIsHome,
    );
  }

  Route get _savedOutfitRoute {
    return MaterialPageRoute(
      builder: (_) => OutfitPresenterScreen(
        _outfitSaver.outfit,
      ),
    );
  }

  bool _routeIsHome(route) => route.isFirst;
}

class _OutfitSaver {
  final _outfitManager = GetIt.I.get<OutfitManager>();
  Outfit _outfit;

  _OutfitSaver({required Outfit outfit}) : _outfit = outfit;

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
