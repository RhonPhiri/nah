import 'package:logging/logging.dart';
import 'package:nah/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final _log = Logger("SHARED_PREFERENCES");

  static const _hymnalIdKey = "HYMNALID";

  Future<Result<int?>> fetchHymnalId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _log.fine("Got the stored hymnal id from shared preferences");
      return Result.success(prefs.getInt(_hymnalIdKey));
    } on Exception catch (e) {
      _log.warning("Failed to get hymnal id from shared preferences", e);
      return Result.error(Exception(e));
    }
  }

  Future<Result<void>> saveHymnalId(int hymnalId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _log.fine("Storing the hymnal id in shared prefs");
      await prefs.setInt(_hymnalIdKey, hymnalId);
      return Result.success(null);
    } on Exception catch (e) {
      _log.warning("Failed to save the current selected hymnal id");
      return Result.error(Exception(e));
    }
  }
}
