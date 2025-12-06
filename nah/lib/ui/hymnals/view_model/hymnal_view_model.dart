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
    load = Command0(_load)..execute();
  }

  List<Hymnal> _hymnals = [];
  List<Hymnal> get hymnals => _hymnals;

  late Command0 load;

  Future<Result> _load() async {
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
}
