import 'package:flutter/material.dart';
import 'package:nah/data/repository/hymn/hymn_repository.dart';
import 'package:nah/data/repository/hymnal/hymnal_repository.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/utils/command.dart';
import 'package:nah/utils/log_levels.dart';
import 'package:nah/utils/result.dart';
import 'dart:developer' show log;

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required HymnalRepository hymnalRepository,
    required HymnRepository hymnRepository,
  }) : _hymnalRepository = hymnalRepository,
       _hymnRepository = hymnRepository {
    load = Command0<List<Hymn>>(_load)..execute();
  }

  static const _name = "HomeViewModel";
  final HymnalRepository _hymnalRepository;
  final HymnRepository _hymnRepository;

  List<Hymn> _hymns = [];

  late Command0 load;

  List<Hymn> get hymns => List.unmodifiable(_hymns);

  Future<Result<List<Hymn>>> _load() async {
    final hymnalLanguage = await _hymnalRepository.getStoredHymnaLanguage();

    if (hymnalLanguage is Error<String?>) {
      log(
        "Failure getting stored hymnal language",
        name: _name,
        level: Level.severe,
        error: hymnalLanguage.error,
      );
    }
    final result = await _hymnRepository.getHymns(
      (hymnalLanguage as Success<String?>).data ?? "",
    );
    switch (result) {
      case Success<List<Hymn>>():
        log("Successfully loaded hymns", name: _name, level: Level.fine);
        _hymns = result.data;
      case Error<List<Hymn>>():
        log(
          "Failure getting hymns from hymn repository",
          name: _name,
          level: Level.severe,
          error: result.error,
        );
    }
    return result;
  }
}
