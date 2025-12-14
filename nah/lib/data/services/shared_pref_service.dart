import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final _log = Logger("SHARED_PREFERENCES");

  static const _hymnalKey = "HYMNALID";

  static const _usageStatusKey = "USAGE";

  Future<Result<Hymnal?>> fetchHymnal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _log.fine("Accessing shared preferences successful: getting hymnal");

      final storedJson = prefs.getString(_hymnalKey);

      if (storedJson != null) {
        return Result.success(Hymnal.fromJson(jsonDecode(storedJson)));
      }

      return Result.success(null);
    } on Exception catch (e) {
      _log.warning("Failed to access the shared preferences to get hymnal", e);
      return Result.error(Exception(e));
    }
  }

  Future<Result<void>> saveHymnal(Hymnal hymnal) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _log.fine("Accessing shared preferences successful: setting hymnal");
      final json = jsonEncode(hymnal.toJson());
      await prefs.setString(_hymnalKey, json);
      return Result.success(null);
    } on Exception catch (e) {
      _log.warning("Failed to save the current selected hymnal");
      return Result.error(Exception(e));
    }
  }

  Future<Result<bool?>> fetchUsageState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _log.fine(
        "Accessing shared preferences successful: getting usage status",
      );
      return Result.success(prefs.getBool(_usageStatusKey));
    } on Exception catch (e) {
      _log.warning(
        "Failed to access the shared preferences to get hymnal id",
        e,
      );
      return Result.error(Exception(e));
    }
  }

  Future<Result<void>> saveUsageStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _log.fine("Accessing shared preferences successful: setting usageStatus");
      await prefs.setBool(_usageStatusKey, false);
      return Result.success(null);
    } on Exception catch (e) {
      _log.warning("Failed to set the usage status of the user");
      return Result.error(Exception(e));
    }
  }
}
