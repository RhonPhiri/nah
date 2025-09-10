import 'package:nah/data/repository/on_boarding/on_boarding_repository.dart';
import 'package:nah/data/service/shared_preferences_service.dart';
import 'package:nah/utils/log_levels.dart';
import 'package:nah/utils/result.dart';
import 'dart:developer' show log;

/// [OnBoardingRepositoryLocal] manages the fetching and setting of hymnal language on first start up
class OnBoardingRepositoryLocal extends OnBoardingRepository {
  final SharedPrefService _sharedPrefService;

  OnBoardingRepositoryLocal({required SharedPrefService sharedPrefService})
    : _sharedPrefService = sharedPrefService;

  /// Variable to check if the user is running the app for the first time
  bool? _isInitialLaunch;

  static const _repoName = "OnBoardingRepositoryLocal";

  @override
  Future<bool> get isInitialLaunch async {
    // Check if _isFirstTime is not yet assigned
    if (_isInitialLaunch != null) {
      return _isInitialLaunch!;
    }
    // Check local storage through shared prefs if this is an initial launch
    await _fetch();
    return _isInitialLaunch ?? true;
  }

  /// Method to fetch the stored hymnal language from the device
  Future<void> _fetch() async {
    final result = await _sharedPrefService.getStoredHymnalLanguage();
    switch (result) {
      case Success<String?>():
        // return true if theere is no stored hymnal language
        _isInitialLaunch = result.data == null;
      case Error<String?>():
        log(
          "Failure fetching stored hymnal language",
          name: _repoName,
          level: Level.severe,
          error: result.error,
        );
    }
  }

  @override
  Future<Result<void>> enterApp({required String language}) async {
    // update the use status
    try {
      _isInitialLaunch = false;

      //Store the selected hymnal language
      final result = await _sharedPrefService.setHymnalLanguage(language);
      if (result is Error<void>) {
        log(
          "Error setting the selected hymnal language",
          name: _repoName,
          level: Level.severe,
          error: result.error,
        );
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
