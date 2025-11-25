import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';

class HymnalRepositoryDev implements HymnalRepository {
  final DataService _dataService;

  HymnalRepositoryDev({required DataService dataService})
    : _dataService = dataService;

  @override
  Future<Result<List<Hymnal>>> getHymnals() async {
    try {
      final hymnals = await _dataService.getHymnals();
      return Result.success(hymnals);
    } on Exception catch (e, stackTrace) {
      return Result.error(Exception("$e, $stackTrace"));
    }
  }
}
