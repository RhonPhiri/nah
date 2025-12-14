import 'package:nah/data/services/shared_pref_service.dart';
import 'package:nah/utils/result.dart';

class FakeSharedPreferenceService extends SharedPrefService {
  String? hymnal;
  bool? usageStatus;

  @override
  Future<Result<String?>> fetchHymnal() async {
    return Result.success(hymnal);
  }

  @override
  Future<Result<void>> saveHymnal(String hymnal) async {
    this.hymnal = hymnal;
    return Result.success(null);
  }

  @override
  Future<Result<bool?>> fetchUsageState() async {
    return Result.success(usageStatus);
  }

  @override
  Future<Result<void>> saveUsageStatus() async {
    usageStatus = false;
    return Result.success(null);
  }
}
