import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/data_gateway.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/use_case_utils.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

class ClothItemSaverImpl extends ClothItemSaver with UseCaseUtils {
  @override
  Future<void> save(ClothItem item) async {
    await dataGateway.save(item);
    await _MatchingItemWebRepairer(item).repairWeb();
    notifyUi();
  }
}

class _MatchingItemWebRepairer {
  final _dataGateway = GetIt.I<ClothItemDataGateway>();

  final String _subjectId;
  final List<String> _subjectMatchingItemIds;

  _MatchingItemWebRepairer(ClothItem subject)
      : _subjectId = subject.id,
        _subjectMatchingItemIds = subject.matchingItems;

  Future<void> repairWeb() async {
    await _updateNewlyMatchedItems();
    await _updatePreviouslyMatchedItems();
  }

  Future<void> _updateNewlyMatchedItems() async {
    for (final subjectMatchingItem in await _subjectMatchingItems()) {
      if (!_subjectRecordedAsMatchingItemOf(subjectMatchingItem)) {
        _addSubjectToMatchingItemsOf(subjectMatchingItem);
      }
    }
  }

  Future<List<ClothItem>> _subjectMatchingItems() async {
    return [
      for (final id in _subjectMatchingItemIds) await _dataGateway.getById(id)
    ];
  }

  bool _subjectRecordedAsMatchingItemOf(ClothItem item) {
    return item.matchingItems.contains(_subjectId);
  }

  Future<void> _addSubjectToMatchingItemsOf(ClothItem item) async {
    await _saveItem(
      item.copyWith(
        matchingItems: [
          ...item.matchingItems,
          _subjectId,
        ],
      ),
    );
  }

  Future<void> _updatePreviouslyMatchedItems() async {
    for (final item in await _itemsRecordingSubjectAsMatching()) {
      if (!_subjectMatchingItemIds.contains(item.id)) {
        _removeSubjectFromMatchingItemsOf(item);
      }
    }
  }

  Future<List<ClothItem>> _itemsRecordingSubjectAsMatching() async {
    return [
      for (final item in await _dataGateway.getAllItems())
        if (_subjectRecordedAsMatchingItemOf(item)) item
    ];
  }

  Future<void> _removeSubjectFromMatchingItemsOf(ClothItem item) async {
    await _saveItem(
      item.copyWith(
        matchingItems: _matchingItemsListWithoutSubjectIdOf(item),
      ),
    );
  }

  List<String> _matchingItemsListWithoutSubjectIdOf(ClothItem item) {
    return [
      for (final id in item.matchingItems)
        if (id != _subjectId) id
    ];
  }

  Future<void> _saveItem(ClothItem item) async => _dataGateway.save(item);
}
