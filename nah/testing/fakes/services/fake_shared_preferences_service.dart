import 'package:nah/data/service/shared_preferences_service.dart';
import 'package:nah/utils/result.dart';

class FakeSharedPreferencesService implements SharedPrefService {
  String? language;

  @override
  Future<Result<String?>> getStoredHymnalLanguage() async {
    return Result.success(language);
  }

  @override
  Future<Result<void>> setHymnalLanguage(String language) async {
    this.language = language;
    return Result.success(null);
  }
}
