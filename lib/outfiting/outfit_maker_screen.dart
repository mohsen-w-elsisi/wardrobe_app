import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_organiser.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views_utils.dart';
import 'package:wardrobe_app/outfiting/outfit_maker_manager.dart';

import 'outfit_presenter_screen.dart';

class OutfitMakerScreen extends StatelessWidget {
  final ClothItemManager _clothItemManager = GetIt.I.get<ClothItemManager>();

  OutfitMakerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("outfit maker"),
      ),
      body: ListenableBuilder(
        listenable: _clothItemManager,
        builder: (context, _) => _Stepper(),
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();
  final outfitMakerManager = OutfitMakerManager();

  _Stepper({super.key});

  @override
  Widget build(BuildContext context) {
    outfitMakerManager.onLastStepDone = () => _presentOutfit(context);

    return ListenableBuilder(
      listenable: outfitMakerManager,
      builder: (_, __) => Stepper(
        currentStep: outfitMakerManager.currentStep,
        onStepContinue: outfitMakerManager.nextStep,
        onStepCancel: outfitMakerManager.previousStep,
        onStepTapped: (value) => outfitMakerManager.currentStep = value,
        controlsBuilder: (_, details) => _skipButton(details),
        steps: [for (final type in ClothItemType.values) _step(type)],
      ),
    );
  }

  Widget _skipButton(ControlsDetails details) {
    return Align(
      alignment: Alignment.centerLeft,
      child: OutlinedButton(
        onPressed: () {
          outfitMakerManager.nextStep();
          outfitMakerManager.clearSelectedItemOfType(
            ClothItemType.values[details.currentStep],
          );
        },
        child: const Text("skip"),
      ),
    );
  }

  Step _step(ClothItemType type) {
    return Step(
      title: Text(_stepLabel(type)),
      content: Column(
        children: [
          for (final item in outfitMakerManager.validItemsOfType(type))
            _ItemChoiceTile(outfitMakerManager: outfitMakerManager, item: item)
        ],
      ),
    );
  }

  String _stepLabel(ClothItemType type) =>
      "${type.name}: ${outfitMakerManager.selectedItems[type]?.name ?? ""}";

  void _presentOutfit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OutfitPresenterScreen(
          outfitMakerManager.selectedItemsAsList,
        ),
      ),
    );
  }
}

class _ItemChoiceTile extends StatelessWidget {
  final OutfitMakerManager outfitMakerManager;
  final ClothItem item;

  const _ItemChoiceTile({
    super.key,
    required this.outfitMakerManager,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        outfitMakerManager.setSelectedItem(item.type, item);
        outfitMakerManager.nextStep();
      },
      title: Text(item.name),
      trailing: SizedBox(
        width: 100,
        child: ClothItemAttributeIconRow(
          item.attributes,
          alignEnd: true,
        ),
      ),
    );
  }
}
