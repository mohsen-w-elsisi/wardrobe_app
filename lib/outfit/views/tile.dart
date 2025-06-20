import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/attribute_icon_row.dart';
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
      subtitle: FutureBuilder(
        future: _itemNames,
        initialData: "",
        builder: (_, snapshot) {
          return Text(snapshot.data!, overflow: TextOverflow.ellipsis);
        },
      ),
      trailing: FutureBuilder(
        future: _attributes,
        initialData: const <ClothItemAttribute>[],
        builder: (_, snapshot) {
          return _attributesRow(snapshot.data!);
        },
      ),
    );
  }

  Future<String> get _itemNames => _OutfitItemsLabeler(_outfit.items).label();

  Widget _attributesRow(Iterable<ClothItemAttribute> attributes) {
    return SizedBox(
      width: 100,
      child: ClothItemAttributeIconRow(attributes, alignEnd: true),
    );
  }

  Future<Iterable<ClothItemAttribute>> get _attributes {
    return _OutfitAttributeCalculator(_outfit.items).attributes();
  }

  Widget _openBuilder(_, __) => OutfitPresenterScreen(_outfit);
}

class _OutfitItemsLabeler {
  static const _nameDivider = "-";

  final _clothItemQuerier = GetIt.I<ClothItemQuerier>();

  final Iterable<String> _ids;
  late final Iterable<ClothItem> _clothitems;
  late final Iterable<String> _names;
  late String _label;

  _OutfitItemsLabeler(this._ids);

  Future<String> label() async {
    await _getClothItems();
    _getNames();
    _concatNames();
    return _label;
  }

  Future<void> _getClothItems() async {
    _clothitems = [
      for (final id in _ids) await _clothItemQuerier.getById(id),
    ].nonNulls;
  }

  void _getNames() {
    _names = [for (final item in _clothitems) item.name];
  }

  void _concatNames() {
    _label = _names.join(" $_nameDivider ");
  }
}

class _OutfitAttributeCalculator {
  final _clothItemQuerier = GetIt.I<ClothItemQuerier>();
  final Iterable<String> _ids;
  late final Iterable<ClothItem> _clothItems;
  late final List<List<ClothItemAttribute>> _attributeMatrix;
  late final Iterable<ClothItemAttribute> _attributes;

  _OutfitAttributeCalculator(this._ids);

  Future<Iterable<ClothItemAttribute>> attributes() async {
    await _getClothItems();
    _createInitialAttributeMatrix();
    _removeEmptyAttributeRows();
    _collapseMatrixToList();
    return _attributes;
  }

  Future<void> _getClothItems() async {
    _clothItems = [
      for (final id in _ids) await _clothItemQuerier.getById(id),
    ].nonNulls;
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
