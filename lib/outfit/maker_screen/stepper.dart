import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/organiser.dart';
import 'package:wardrobe_app/cloth_item_views/details_screen.dart';
import 'package:wardrobe_app/cloth_item_views/dispay_options/sort_mode.dart';
import 'package:wardrobe_app/cloth_item_views/dispay_options/type.dart';
import 'package:wardrobe_app/cloth_item_views/utils.dart';
import 'package:wardrobe_app/outfit/outfit.dart';

import 'manager.dart';
import '../presenter_screen.dart';

class OutfitMakerStepper extends StatelessWidget {
  final OutfitMakerManager outfitMakerManager;

  const OutfitMakerStepper({super.key, required this.outfitMakerManager});

  @override
  Widget build(BuildContext context) {
    outfitMakerManager.onLastStepDone = () => _presentOutfit(context);

    return ListenableBuilder(
      listenable: outfitMakerManager,
      builder: (_, __) => Stepper(
        physics: const NeverScrollableScrollPhysics(),
        currentStep: outfitMakerManager.currentStep,
        onStepContinue: outfitMakerManager.nextStep,
        onStepCancel: outfitMakerManager.previousStep,
        onStepTapped: (value) => outfitMakerManager.currentStep = value,
        controlsBuilder: (_, __) => _SkipButton(outfitMakerManager),
        stepIconBuilder: (index, __) => _StepIcon(ClothItemType.values[index]),
        steps: _steps,
      ),
    );
  }

  List<Step> get _steps =>
      [for (final type in ClothItemType.values) _stepForType(type)];

  Step _stepForType(ClothItemType type) {
    return _Step(outfitMakerManager, type).step;
  }

  void _presentOutfit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OutfitPresenterScreen(
          _outfit,
        ),
      ),
    );
  }

  Outfit get _outfit => Outfit.ephemiral(
        items: [
          for (final item in outfitMakerManager.selectedItemsAsList) item.id
        ],
      );
}

class _StepIcon extends StatelessWidget {
  final ClothItemType type;

  const _StepIcon(this.type);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Center(
        child: SvgPicture.asset(
          _iconAssetPath,
          height: 20,
        ),
      ),
    );
  }

  String get _iconAssetPath => clothItemTypeDisplayOptions[type]!.icon;
}

class _SkipButton extends StatelessWidget {
  final OutfitMakerManager outfitMakerManager;
  late final ClothItemType _type;

  _SkipButton(this.outfitMakerManager) {
    _type = outfitMakerManager.typeOfCurrentStep;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: OutlinedButton(
        onPressed: _skipStepAndClearItem,
        child: const Text("skip"),
      ),
    );
  }

  void _skipStepAndClearItem() {
    outfitMakerManager.nextStep();
    outfitMakerManager.clearSelectedItemOfType(_type);
  }
}

class _Step {
  final OutfitMakerManager outfitMakerManager;
  final ClothItemType type;
  late final List<ClothItem> validItems;

  _Step(this.outfitMakerManager, this.type) {
    validItems = outfitMakerManager.validItemsOfType(type);
  }

  Step get step {
    return Step(
      state: validItems.isEmpty ? StepState.disabled : StepState.indexed,
      title: Text(_stepLabel),
      content: Column(
        children: _itemChoiceTilesForValidItems,
      ),
    );
  }

  String get _stepLabel {
    final typeName = clothItemTypeDisplayOptions[type]!.text;
    final colom = outfitMakerManager.itemOfTypeIsSelected(type) ? ":" : "";
    final selectedItem = outfitMakerManager.selectedItems[type]?.name ?? "";
    return "$typeName$colom $selectedItem";
  }

  List<Widget> get _itemChoiceTilesForValidItems {
    final sortedValidItems = ClothItemOrganiser(validItems)
        .sortFavouritesFirst(ClothItemSortMode.byName);
    return [
      for (final item in sortedValidItems)
        _ItemChoiceTile(outfitMakerManager: outfitMakerManager, item: item)
    ];
  }
}

class _ItemChoiceTile extends StatelessWidget {
  final OutfitMakerManager outfitMakerManager;
  final ClothItem item;

  const _ItemChoiceTile({
    required this.outfitMakerManager,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _setAsSelectedItemAndNextStep,
      onLongPress: () => _openDetailsScreenForItem(context),
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

  void _setAsSelectedItemAndNextStep() {
    outfitMakerManager.setSelectedItem(item);
    outfitMakerManager.nextStep();
  }

  void _openDetailsScreenForItem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ClothItemDetailScreen(item.id),
      ),
    );
  }
}