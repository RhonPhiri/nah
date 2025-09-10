import 'package:nah/data/repository/hymn/hymn_repository.dart';
import 'package:nah/data/repository/hymnal/hymnal_repository.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/log_levels.dart';
import 'package:nah/utils/result.dart';
import 'dart:developer' show log;

class LoadHymnUseCase {
  LoadHymnUseCase({
    required HymnRepository hymnRepository,
    required HymnalRepository hymnalRepository,
  }) : _hymnRepository = hymnRepository,
       _hymnalRepository = hymnalRepository;
  static const _name = "LoadHymnUseCase";
  final HymnRepository _hymnRepository;
  final HymnalRepository _hymnalRepository;

  Future<Result<({String hymnalTitle, List<Hymn> hymns})>> fetchHymns() async {
    ///Variable to hold the hymnal language
    String hymnalLanguage = "";

    //First, fetch the current selected hymnal from shared prefs
    final hymnal = await _hymnalRepository.getStoredHymnal();
    switch (hymnal) {
      case Success<Hymnal>():
        hymnalLanguage = hymnal.data.language;
      case Error<Hymnal>():
        log(
          "Failure loading stored hymnal from shared prefs",
          name: _name,
          level: Level.shout,
          error: hymnal.error,
        );
    }

    final result = await _hymnRepository.getHymns(hymnalLanguage);
    switch (result) {
      case Success<List<Hymn>>():
        return Result.success((
          hymnalTitle: (hymnal as Success<Hymnal>).data.title,
          hymns: result.data,
        ));
      case Error<List<Hymn>>():
        return Result.error(result.error);
    }
  }
}
