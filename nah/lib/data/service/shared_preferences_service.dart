import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/log_levels.dart';
import 'package:nah/utils/result.dart';
import 'dart:developer' show log;
import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPrefService] manages the setting & retrival of assets stored using shared_preferences package
class SharedPrefService {
  static const _logName = "Shared Prefernces";
  static const _hymnalKey = "HYMNAL_KEY";

  /// Method to get the stored hymnal on first app startup or upon selecting a hymnal in hymnal screen
  Future<Result<Hymnal>> getStoredHymnal() async {
    log("Fetching stored Hymnal", name: _logName, level: Level.config);
    //Instanciating the shared prefs
    final prefs = await SharedPreferences.getInstance();
    try {
      //Get hymnal from the fetched json, returning a hymnal or an error if the json is an empty string
      final json = prefs.getString(_hymnalKey) ?? "";
      final hymnal = Hymnal.fromJson(json);
      log(
        "Fetching stored hymnal Successful",
        name: _logName,
        level: Level.fine,
      );
      //Returned if the json is a hymnal

      return Result.success(hymnal);
    } catch (e) {
      log(
        "Error on fetching stored hymnal",
        name: _logName,
        level: Level.warning,
        error: e,
      );
      //Returned if the json is an empty string
      return Result.error(Exception(e));
    }
  }

  /// Mtheod to set the hymnal  on first app startup
  Future<Result<void>> setHymnal(Hymnal hymnal) async {
    log("Setting stored Hymnal ", name: _logName, level: Level.config);
    //Instanciate the shared prefs
    final prefs = await SharedPreferences.getInstance();
    //Converting the hymnal parameter into a json string
    final json = hymnal.toJson();
    await prefs.setString(_hymnalKey, json);
    log(
      "Setting stored Hymnal successful",
      name: _logName,
      level: Level.config,
    );

    return Result.success(null);
  }
}
