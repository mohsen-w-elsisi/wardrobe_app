import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';
import 'package:wardrobe_app/cloth_item/views/attribute_icon_row.dart';
import '../backend/outfit.dart';
import 'presenter_screen.dart';

class OutfitTile extends StatelessWidget {
  final Outfit _outfit;

  const OutfitTile(this._outfit, {super.key});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      closedColor: _color(context),
      closedBuilder: _closedBuilder,
      openBuilder: _openBuilder,
    );
  }

  Color _color(BuildContext context) => Theme.of(context).colorScheme.surface;

  Widget _closedBuilder(_, __) {
    return ListTile(
      title: Text(_outfit.name),
      subtitle: Text(_itemNames, overflow: TextOverflow.ellipsis),
      trailing: _attributesRow,
    );
  }

  String get _itemNames => _OutfitItemsLabeler(_outfit.items).label();

  Widget get _attributesRow {
    return SizedBox(
      width: 100,
      child: ClothItemAttributeIconRow(_attributes, alignEnd: true),
    );
  }

  Iterable<ClothItemAttribute> get _attributes {
    return _OutfitAttributeCalculator(_outfit.items).attributes();
  }

  Widget _openBuilder(_, __) => OutfitPresenterScreen(_outfit);
}

class _OutfitItemsLabeler {
  static const _nameDivider = "-";

  final _clothItemManager = GetIt.I.get<ClothItemManager>();

  final Iterable<String> _ids;
  late final Iterable<ClothItem> _clothitems;
  late final Iterable<String> _names;
  late String _label;

  _OutfitItemsLabeler(this._ids);

  String label() {
    _getClothItems();
    _getNames();
    _concatNames();
    return _label;
  }

  void _getClothItems() {
    _clothitems = _ids.map(_clothItemManager.getClothItemById).nonNulls;
  }

  void _getNames() {
    _names = [for (final item in _clothitems) item.name];
  }

  void _concatNames() {
    _label = _names.join(" $_nameDivider ");
  }
}

class _OutfitAttributeCalculator {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();
  final Iterable<String> _ids;
  late final Iterable<ClothItem> _clothItems;
  late final List<List<ClothItemAttribute>> _attributeMatrix;
  late final Iterable<ClothItemAttribute> _attributes;

  _OutfitAttributeCalculator(this._ids);

  Iterable<ClothItemAttribute> attributes() {
    _getClothItems();
    _createInitialAttributeMatrix();
    _removeEmptyAttributeRows();
    _collapseMatrixToList();
    return _attributes;
  }

  void _getClothItems() {
    _clothItems = _ids.map(_clothItemManager.getClothItemById).nonNulls;
  }

  void _createInitialAttributeMatrix() {
    _attributeMatrix = [
      for (final item in _clothItems)
        [for (final attribute in item.attributes) attribute]
    ];
  }

  void _removeEmptyAttributeRows() {
    _attributeMatrix.removeWhere(
      (row) => row.isEmpty,
    );
  }

  void _collapseMatrixToList() {
    if (_attributeMatrix.isEmpty) {
      _attributes = [];
    } else {
      _attributes = _attributeMatrix
          .map((e) => e.toSet())
          .reduce((a, b) => a.intersection(b))
          .toSet();
    }
  }
}
