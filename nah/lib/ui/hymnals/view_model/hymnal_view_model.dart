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
    selectHymnal = Command1<void, Hymnal>(_selectHymnal);
  }

  List<Hymnal> _hymnals = [];
  List<Hymnal> get hymnals => _hymnals;

  Hymnal? _selectedHymnal;
  Hymnal? get selectedHymnal => _selectedHymnal;

  late final Command0 load;
  late final Command1 selectHymnal;

  Future<Result<List<Hymnal>>> _load() async {
    try {
      final result = await _hymnalRepository.getHymnals();
      if (result is Success<List<Hymnal>>) {
        _hymnals = result.data;
        _log.fine("Loaded hymnals");
        await _getStoredHymnal();
      } else if (result is Error<List<Hymnal>>) {
        _log.warning("Failed to load hymnals", result.error);
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<void> _getStoredHymnal() async {
    try {
      final result = await _hymnalRepository.getStoredHymnal();

      switch (result) {
        case Success<Hymnal?>():
          if (result.data == null) {
            _selectHymnal(hymnals.first);
            break;
          }
          _selectedHymnal = result.data;
        case Error<Hymnal?>():
          _log.warning("Failed to get the stored hymnal id", result.error);
      }
    } on Exception catch (e) {
      _log.warning("Error getting the stored hymnal", e);
    }
  }

  Future<Result<void>> _selectHymnal(Hymnal hymnal) async {
    if (_selectedHymnal == hymnal) {
      return Result.success(null);
    }

    _selectedHymnal = hymnal;

    try {
      final result = await _hymnalRepository.storeSelectedHymnal(hymnal);
      if (result is Success<void>) {
        _log.fine("Stored the current selected hymnal");
      } else {
        _log.warning("Failed to store the current selected hymnal");
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _hymnals.clear();
    _selectedHymnal = null;
    load.clearResult();
    selectHymnal.clearResult();
    super.dispose();
  }
}
