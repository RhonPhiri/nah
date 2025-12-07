import 'package:nah/data/services/shared_pref_service.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';

class HymnalRepositoryDev implements HymnalRepository {
  final DataService _dataService;
  final SharedPrefService _prefs;

  HymnalRepositoryDev({
    required DataService dataService,
    required SharedPrefService prefs,
  }) : _dataService = dataService,
       _prefs = prefs;

  @override
  Future<Result<List<Hymnal>>> getHymnals() async {
    final result = await _dataService.getHymnals();
    if (result is Success<List<Hymnal>>) {
      return Result.success(result.data);
    }
    return Result.error((result as Error<List<Hymnal>>).error);
  }

  @override
  Future<Result<int?>> getStoredHymnalId() async {
    try {
      final result = await _prefs.fetchHymnalId();
      if (result is Success<int?>) {
        return Result.success(result.data);
      }
      return Result.error((result as Error).error);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> storeSelectedHymnalId(int hymnalId) async {
    try {
      await _prefs.saveHymnalId(hymnalId);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }
}
