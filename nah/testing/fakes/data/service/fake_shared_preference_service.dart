import 'package:nah/data/services/shared_pref_service.dart';
import 'package:nah/utils/result.dart';

class FakeSharedPreferenceService implements SharedPrefService {
  int? hymnalId;
  @override
  Future<Result<int?>> fetchHymnalId() async {
    return Result.success(hymnalId);
  }

  @override
  Future<Result<void>> saveHymnalId(int hymnalId) async {
    this.hymnalId = hymnalId;
    return Result.success(null);
  }
}
