import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/views/compound_view/filter_modal.dart';
import 'package:wardrobe_app/cloth_item/presenters/sort_mode.dart';

import 'settings.dart';

class ClothItemCompoundViewControlBar extends StatelessWidget {
  final ClothItemCompoundViewManager settingsController;

  const ClothItemCompoundViewControlBar(this.settingsController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _filterAttributesButton(context),
        _sortByLabel(context),
        _sortModeDropDown(),
        const Spacer(),
        _layoutToggleButton()
      ],
    );
  }

  Widget _sortByLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        "sort by ",
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  Widget _layoutToggleButton() {
    return IconButton(
      tooltip: "switch layout",
      onPressed: toggleLayout,
      icon: _LayoutToggleIcon(
        layout: settingsController.settings.layout,
      ),
    );
  }

  Widget _sortModeDropDown() {
    return DropdownButton(
      icon: const Icon(Icons.sort),
      value: settingsController.settings.sortMode,
      onChanged: (value) => settingsController.setSortMode(value!),
      items: [
        for (final sortMode in ClothItemSortMode.values)
          DropdownMenuItem(
            value: sortMode,
            child: Text(clothItemSortModeDisplayOptions[sortMode]!.text),
          )
      ],
    );
  }

  void toggleLayout() {
    settingsController.setLayout(
      settingsController.layoutIs(ClothItemCompoundViewLayout.grid)
          ? ClothItemCompoundViewLayout.list
          : ClothItemCompoundViewLayout.grid,
    );
  }

  Widget _filterAttributesButton(BuildContext context) {
    return IconButton(
      tooltip: "filter",
      onPressed: () => _openAttributeFilterModal(context),
      icon: const Icon(Icons.tune),
    );
  }

  void _openAttributeFilterModal(BuildContext context) {
    ClothItemCompoundViewFiltersModal(
      settingsController: settingsController,
    ).show(context);
  }
}

class _LayoutToggleIcon extends StatefulWidget {
  final ClothItemCompoundViewLayout layout;

  const _LayoutToggleIcon({required this.layout});

  @override
  State<_LayoutToggleIcon> createState() => _LayoutToggleIconState();
}

class _LayoutToggleIconState extends State<_LayoutToggleIcon>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    _controller = AnimationController(
      vsync: this,
      duration: layoutSwitchAnimationDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateAnimationProgress();
    return AnimatedIcon(
      icon: AnimatedIcons.view_list,
      progress: _controller,
    );
  }

  void _updateAnimationProgress() {
    switch (widget.layout) {
      case ClothItemCompoundViewLayout.grid:
        _controller.forward();
      case ClothItemCompoundViewLayout.list:
        _controller.reverse();
    }
  }
}
