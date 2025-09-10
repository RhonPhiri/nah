import 'package:flutter/material.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/use_cases/hymn/load_hymn_use_case.dart';
import 'package:nah/utils/command.dart';
import 'package:nah/utils/log_levels.dart';
import 'package:nah/utils/result.dart';
import 'dart:developer' show log;

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required LoadHymnUseCase loadHymnUseCase})
    : _loadHymnUseCase = loadHymnUseCase {
    load = Command0(_load)..execute();
  }

  static const _name = "HomeViewModel";

  final LoadHymnUseCase _loadHymnUseCase;

  String _selectedHymnalTitle = "";
  List<Hymn> _hymns = [];

  late Command0 load;

  String get hymnalTitle => _selectedHymnalTitle;
  List<Hymn> get hymns => List.unmodifiable(_hymns);

  Future<Result> _load() async {
    final result = await _loadHymnUseCase.fetchHymns();
    switch (result) {
      case Success<({String hymnalTitle, List<Hymn> hymns})>():
        _selectedHymnalTitle = result.data.hymnalTitle;
        _hymns = result.data.hymns;
      case Error<({String hymnalTitle, List<Hymn> hymns})>():
        log(
          "Error loading HYMNS and SELECTEDHYMNALTITLE",
          name: _name,
          level: Level.severe,
          error: result.error,
        );
    }
    return result;
  }
}
