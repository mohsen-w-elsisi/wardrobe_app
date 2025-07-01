import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/types.dart';

class ClothItemTypeSelector extends StatelessWidget {
  final ClothItemEditingManager editingManager;

  const ClothItemTypeSelector({
    super.key,
    required this.editingManager,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "type: ",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _DropDown(newClothItemManager: editingManager),
        ),
      ],
    );
  }
}

class _DropDown extends StatefulWidget {
  final ClothItemEditingManager newClothItemManager;

  const _DropDown({
    required this.newClothItemManager,
  });

  @override
  State<_DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<_DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.newClothItemManager.type,
      onChanged: _updateNewItemType,
      items: menuItems(context),
    );
  }

  void _updateNewItemType(ClothItemType? type) {
    setState(
      () => widget.newClothItemManager.type = type!,
    );
  }

  List<DropdownMenuItem<ClothItemType>> menuItems(BuildContext context) {
    return [
      for (final type in ClothItemType.values)
        _DropDownButtonBuilder(context, type).menuItem
    ];
  }
}

class _DropDownButtonBuilder {
  final ClothItemType _type;
  final BuildContext _context;

  _DropDownButtonBuilder(this._context, this._type);

  DropdownMenuItem<ClothItemType> get menuItem {
    return DropdownMenuItem(
      value: _type,
      child: Row(
        children: [
          _icon,
          _label,
        ],
      ),
    );
  }

  Widget get _icon {
    return SvgPicture.asset(
      ClothItemTypeDisplayConfig.of(_type).iconPath(_context),
      height: 16,
    );
  }

  Widget get _label {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(_typeName),
    );
  }

  String get _typeName => ClothItemTypeDisplayConfig.of(_type).text;
}
