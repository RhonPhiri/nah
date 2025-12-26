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
    selectedHymnal.addListener(storeSelectedHymnal);
  }

  List<Hymnal> _hymnals = [];
  List<Hymnal> get hymnals => _hymnals;

  ValueNotifier<Hymnal?> selectedHymnal = ValueNotifier(null);

  late final Command0 load;

  /// Method to load the hymnals from the db
  /// Called upon instantiation of the viewmodel
  Future<Result<List<Hymnal>>> _load() async {
    try {
      final result = await _hymnalRepository.getHymnals();

      switch (result) {
        case Success<List<Hymnal>>():
          _hymnals = result.data;
          _log.fine("Loaded hymnals");
          // After loading the hymnals, fetch the hymnal that was last used in the previous session
          await _getStoredHymnal();
        case Error<List<Hymnal>>():
          _log.warning("Failed to load hymnals", result.error);
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  /// Method to fetch the hymnal that was last used in the previous session
  Future<void> _getStoredHymnal() async {
    try {
      final result = await _hymnalRepository.getStoredHymnal();

      switch (result) {
        case Success<Hymnal?>():
          // If there is a stored hymnal, assign it to the current selected hymnal
          selectedHymnal.value = result.data;
        case Error<Hymnal?>():
          _log.warning("Failed to get the stored hymnal id", result.error);
          // An error indicated that no hymnal was stored, probably it is the first ever session for the user
          // In that case, the first hymnal in the list will be assigned to be the first hymnal
          selectedHymnal.value = _hymnals.first;
      }
    } on Exception catch (e) {
      _log.warning("Error getting the stored hymnal", e);
    }
  }

  /// Method to update the selected hymnal in shared prefs
  Future<void> storeSelectedHymnal() async {
    try {
      if (selectedHymnal.value != null) {
        final result = await _hymnalRepository.storeSelectedHymnal(
          selectedHymnal.value!,
        );

        switch (result) {
          case Success<void>():
            _log.fine("Stored the current selected hymnal");

          case Error<void>():
            _log.warning("Failed to store the current selected hymnal");
        }
      }
    } on Exception catch (e) {
      _log.severe("Error on storing the selected hymnal", e);
    }
  }

  @override
  void dispose() {
    selectedHymnal.dispose();
    _hymnals.clear();
    load.clearResult();
    super.dispose();
  }
}
