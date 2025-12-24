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

  List<Hymn> _hymns = [];

  final ValueNotifier<Hymn?> selectedHymnNotifier = ValueNotifier(null);

  Hymnal? get hymnal => _hymnal;

  List<Hymn> get hymns => List.unmodifiable(_hymns);

  Hymn? get selectedHymn => selectedHymnNotifier.value;

  late final Command0 load;

  /// This method is called when the hymnal screen is popped, causing the rebuilding of the hymnpage
  void setSelectedHymnal(Hymnal? selectedHymnal) {
    if (_hymnal != selectedHymnal) {
      _hymnal = selectedHymnal;
      notifyListeners();
    }
  }

  void setSelectedHymn(Hymn? hymn) {
    if (selectedHymnNotifier.value != hymn) {
      selectedHymnNotifier.value = hymn;
    }
  }

  /// Method to load the hymns from database
  Future<Result<List<Hymn>>> _load() async {
    try {
      // First, fetch the stored hymnal or assign the first hymnal to be the one selected
      final hymnalResult = await _hymnalRepository.getStoredHymnal();
      switch (hymnalResult) {
        case Success<Hymnal?>():
          _log.fine("Fetching stored hymnal successful");
          _hymnal = hymnalResult.data;
        case Error<Hymnal?>():
          _log.warning("Error on loading stored hymnal", hymnalResult.error);

          // If error on getting the stored hymnal, likely due to being the first time the user runs the app
          // fetch hymnals and assign the first
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
