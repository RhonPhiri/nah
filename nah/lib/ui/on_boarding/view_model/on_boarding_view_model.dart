import 'dart:developer' show log;
import 'package:flutter/widgets.dart';
import 'package:nah/data/repository/hymnal/hymnal_repository.dart';
import 'package:nah/data/repository/on_boarding/on_boarding_repository.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/command.dart';
import 'package:nah/utils/log_levels.dart';
import 'package:nah/utils/result.dart';

class OnBoardingViewModel extends ChangeNotifier {
  OnBoardingViewModel({
    required HymnalRepository hymnalRepository,
    required OnBoardingRepository useStatusRepository,
  }) : _hymnalRepository = hymnalRepository,
       _useStatusRepository = useStatusRepository {
    load = Command0(_load)..execute();
    enterApp = Command1<void, String>(_enterApp);
  }

  static const _name = "IntroViewModel";
  final HymnalRepository _hymnalRepository;
  final OnBoardingRepository _useStatusRepository;
  List<Hymnal> _hymnals = [];

  late Command0 load;
  late Command1<void, String> enterApp;

  List<Hymnal> get hymnals => List.unmodifiable(_hymnals);

  Future<Result> _load() async {
    final result = await _hymnalRepository.getHymnals();
    switch (result) {
      case Success<List<Hymnal>>():
        log("Hymnals loaded successfully", name: _name, level: Level.fine);
        _hymnals = result.data;
      case Error<List<Hymnal>>():
        log(
          "Error loading hymnals",
          name: _name,
          level: Level.severe,
          error: result.error,
        );
    }
    return result;
  }

  Future<Result<void>> _enterApp(String language) async {
    log("Entering app from onBoard screen", name: _name, level: Level.fine);
    final result = await _useStatusRepository.enterApp(language: language);
    return result;
  }
}
