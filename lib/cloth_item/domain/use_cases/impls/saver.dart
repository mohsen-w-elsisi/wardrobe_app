import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/data_gateway.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/use_case_utils.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

class ClothItemSaverImpl extends ClothItemSaver with UseCaseUtils {
  @override
  void save(ClothItem item) {
    dataGateway.save(item);
    _MatchingItemWebRepairer(item).repairWeb();
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

  void repairWeb() {
    _updateNewlyMatchedItems();
    _updatePreviouslyMatchedItems();
  }

  void _updateNewlyMatchedItems() {
    for (final subjectMatchingItem in _subjectMatchingItems()) {
      if (!_subjectRecordedAsMatchingItemOf(subjectMatchingItem)) {
        _addSubjectToMatchingItemsOf(subjectMatchingItem);
      }
    }
  }

  List<ClothItem> _subjectMatchingItems() {
    return [for (final id in _subjectMatchingItemIds) _dataGateway.getById(id)];
  }

  bool _subjectRecordedAsMatchingItemOf(ClothItem item) {
    return item.matchingItems.contains(_subjectId);
  }

  void _addSubjectToMatchingItemsOf(ClothItem item) {
    _saveItem(
      item.copyWith(
        matchingItems: [
          ...item.matchingItems,
          _subjectId,
        ],
      ),
    );
  }

  void _updatePreviouslyMatchedItems() {
    for (final item in _itemsRecordingSubjectAsMatching()) {
      if (!_subjectMatchingItemIds.contains(item.id)) {
        _removeSubjectFromMatchingItemsOf(item);
      }
    }
  }

  List<ClothItem> _itemsRecordingSubjectAsMatching() {
    return [
      for (final item in _dataGateway.getAllItems())
        if (_subjectRecordedAsMatchingItemOf(item)) item
    ];
  }

  void _removeSubjectFromMatchingItemsOf(ClothItem item) {
    _saveItem(
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

  void _saveItem(ClothItem item) => _dataGateway.save(item);
}
