import 'package:nah/utils/log_levels.dart';
import 'package:nah/utils/result.dart';
import 'dart:developer' show log;
import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPrefService] manages the setting & retrival of assets stored using shared_preferences package
class SharedPrefService {
  static const _logName = "Shared Prefernces";
  static const _hymnalKey = "HYMNAL_KEY";

  /// Method to get the stored hymnal language that was stored on first app startup
  Future<Result<String?>> getStoredHymnalLanguage() async {
    log("Fetching stored Hymnal Language", name: _logName, level: Level.config);
    final prefs = await SharedPreferences.getInstance();
    try {
      final language = prefs.getString(_hymnalKey);
      log(
        "Fetching stored hymnal language Successful: $language",
        name: _logName,
        level: Level.fine,
      );
      return Result.success(language);
    } catch (e) {
      log(
        "Error on fetching stored hymnal language",
        name: _logName,
        level: Level.warning,
        error: e,
      );
      return Result.error(Exception(e));
    }
  }

  /// Mtheod to set the hymnal language on first app startup
  Future<Result<void>> setHymnalLanguage(String language) async {
    log("Setting stored Hymnal Language", name: _logName, level: Level.config);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_hymnalKey, language);
    log(
      "Setting stored Hymnal Language successful",
      name: _logName,
      level: Level.config,
    );

    return Result.success(null);
  }
}
