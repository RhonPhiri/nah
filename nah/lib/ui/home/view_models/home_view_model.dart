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

  List<Hymn> filterHymnList(String query, bool searchingHymnId) {
    return hymns.where((hymn) {
      // Fetching the lyrics. First, fetching the verses then chorus
      // WAYS TO WRITE THIS
      // 1ST WAY //
      // final verses =
      //     (hymn.lyrics['verses'] as List<dynamic>?)?.map(
      //       (verse) => verse.toString(),
      //     ) ??
      //     [];
      //
      // final chorus = hymn.lyrics['chorus']?.toString() ?? '';

      // 2ND WAY //
      final verses = (hymn.lyrics['verses'] is List)
          ? (hymn.lyrics['verses'] as List)
                .map((verse) => verse.toString())
                .toList()
          : <String>[];

      final chorus = hymn.lyrics['chorus'] as String? ?? '';

      final lowerCaseQuery = query.toLowerCase();

      /// If searchHymnId is true then filter the hymnsbased on the id else, based on the title or lyrics
      return searchingHymnId
          ? hymn.id.toString().startsWith(lowerCaseQuery)
          : hymn.title.toLowerCase().contains(lowerCaseQuery) ||
                verses.any(
                  (verse) => verse.toLowerCase().contains(lowerCaseQuery),
                ) ||
                chorus.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }
}
