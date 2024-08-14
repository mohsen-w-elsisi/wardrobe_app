import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/outfit/manager.dart';
import 'package:wardrobe_app/outfit/outfit.dart';
import 'package:wardrobe_app/outfit/presenter_screen.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _title(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: SizedBox(
              height: 400,
              child: Column(
                children: [
                  _nameTextField(),
                  const Spacer(),
                  _saveButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      "save outfit",
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Widget _nameTextField() {
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(labelText: "outfit name"),
      onChanged: _outfitSaver.updateName,
    );
  }

  Widget _saveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () => _saveOutfit(context),
        child: const Text("save"),
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
