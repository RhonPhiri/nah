import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/command.dart';
import 'package:nah/utils/result.dart';

class HymnalViewModel extends ChangeNotifier {
  final HymnalRepository _hymnalRepository;

  final _log = Logger("HYMNAL_VIEW_MODEL");

  HymnalViewModel({required HymnalRepository hymnalRepository})
    : _hymnalRepository = hymnalRepository {
    load = Command0<List<Hymnal>>(_load)..execute();
    getHymnalId = Command0<int?>(_getStoredHymnalId)..execute();

    selectHymnalId = Command1<void, int>(_selectHymnalId);
  }

  List<Hymnal> _hymnals = [];
  List<Hymnal> get hymnals => _hymnals;

  int? _selectedHymnalId;
  int? get selectedHymnalId => _selectedHymnalId;

  late final Command0 load;
  late final Command0 getHymnalId;

  late final Command1 selectHymnalId;

  Future<Result<List<Hymnal>>> _load() async {
    try {
      final result = await _hymnalRepository.getHymnals();
      switch (result) {
        case Success<List<Hymnal>>():
          _hymnals = result.data;
          _log.fine("Loaded hymnals");
        case Error<List<Hymnal>>():
          _log.warning("Failed to load hymnals", result.error);
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<int?>> _getStoredHymnalId() async {
    try {
      final result = await _hymnalRepository.getStoredHymnalId();
      switch (result) {
        case Success<int?>():
          if (result.data == null) {
            _selectHymnalId(_hymnals.first.id);
          }
          _selectedHymnalId = result.data;
        case Error<int?>():
          _log.warning("Failed to get the stored hymnal id", result.error);
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _selectHymnalId(int hymnalId) async {
    try {
      _selectedHymnalId = hymnalId;
      final result = await _hymnalRepository.storeSelectedHymnalId(hymnalId);
      switch (result) {
        case Success<void>():
          _log.fine("Stored the current selected hymnal Id");

        case Error<void>():
          _log.warning("Failed to store the current selected hymnal id");
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _hymnals.clear();
    _selectedHymnalId = null;
    load.clearResult();
    getHymnalId.clearResult();
    selectHymnalId.clearResult();
    super.dispose();
  }
}
