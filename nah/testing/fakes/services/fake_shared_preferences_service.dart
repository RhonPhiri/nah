import 'package:nah/data/service/shared_preferences_service.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

class FakeSharedPreferencesService implements SharedPrefService {
  String? hymnal;

  @override
  Future<Result<Hymnal>> getStoredHymnal() async {
    return switch (hymnal) {
      (!= null) => Result.success(Hymnal.fromJson(hymnal!)),
      _ => Result.error(Exception("Error loading hymnal")),
    };
  }

  @override
  Future<Result<void>> setHymnal(Hymnal hymnal) async {
    this.hymnal = hymnal.toJson();
    return Result.success(null);
  }
}
