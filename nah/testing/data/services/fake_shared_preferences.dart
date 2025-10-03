import 'package:nah/data/services/shared_preferences_service.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

class FakeSharedPreferences implements SharedPrefService {
  String? hymnal;
  @override
  Future<Result<Hymnal>> getStoredHymnal() async {
    if (hymnal == null) {
      return Result.failure(
        Exception("The hymnal has not been set in shared prefs"),
      );
    }
    return Result.success(Hymnal.fromJson(hymnal!));
  }

  @override
  Future<Result<void>> setHymnal(Hymnal hymnal) async {
    this.hymnal = hymnal.toJson();
    return Result.success(null);
  }
}
