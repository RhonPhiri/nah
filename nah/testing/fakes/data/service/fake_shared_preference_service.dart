import 'dart:convert';
import 'package:nah/data/services/shared_pref_service.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

class FakeSharedPreferenceService extends SharedPrefService {
  String? hymnal;
  bool? usageStatus;

  @override
  Future<Result<Hymnal?>> fetchHymnal() async {
    if (hymnal != null) {
      return (Result.success(Hymnal.fromJson(jsonDecode(hymnal!))));
    }
    return Result.success(null);
  }

  @override
  Future<Result<void>> saveHymnal(Hymnal hymnal) async {
    final hymnalJson = jsonEncode(hymnal.toJson());
    this.hymnal = hymnalJson;
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
