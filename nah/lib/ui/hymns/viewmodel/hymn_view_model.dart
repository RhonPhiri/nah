import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:nah/data/repositories/hymn/hymn_repository.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/command.dart';
import 'package:nah/utils/result.dart';

class HymnViewModel extends ChangeNotifier {
  final HymnRepository _hymnRepository;
  final HymnalRepository _hymnalRepository;

  HymnViewModel({
    required HymnRepository hymnRepository,
    required HymnalRepository hymnalRepository,
  }) : _hymnRepository = hymnRepository,
       _hymnalRepository = hymnalRepository {
    load = Command0(_load)..execute();
  }

  final _log = Logger("HymnViewModel");

  Hymnal? _hymnal;

  // late Hymn _selectedHymn;

  List<Hymn> _hymns = [];

  Hymnal? get hymnal => _hymnal;

  // Hymn get selectedHymn => _selectedHymn;

  List<Hymn> get hymns => List.unmodifiable(_hymns);

  late final Command0 load;

  void setSelectedHymnal(Hymnal? selectedHymnal) {
    if (_hymnal != selectedHymnal) {
      _hymnal = selectedHymnal;
      notifyListeners();
    }
  }

  // void setSelectedHymn(Hymn hymn) {
  //   if (_selectedHymn != hymn) {
  //     _selectedHymn = hymn;
  //     notifyListeners();
  //   }
  // }

  Future<Result<List<Hymn>>> _load() async {
    try {
      final hymnalResult = await _hymnalRepository.getStoredHymnal();
      switch (hymnalResult) {
        case Success<Hymnal?>():
          _log.fine("Fetching stored hymnal successful");
          _hymnal = hymnalResult.data;
        case Error<Hymnal?>():
          _log.warning("Error on loading stored hymnal", hymnalResult.error);
          final hymnalsResult = await _hymnalRepository.getHymnals();
          switch (hymnalsResult) {
            case Success<List<Hymnal>>():
              _log.fine("Fetching hymnals from database successful");
              _hymnal = hymnalsResult.data.first;

            case Error<List<Hymnal>>():
              _log.severe(
                "Error on fetching hymnals from database",
                hymnalsResult.error,
              );
          }
      }

      final result = await _hymnRepository.getHymns(_hymnal!.id);
      switch (result) {
        case Success<List<Hymn>>():
          _hymns = result.data;
          _log.fine("Hymn list loaded successfully");
        case Error<List<Hymn>>():
          _log.warning("Failed to load hymns", result.error);
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
