import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/data/repositories/hymn/hymn_repository.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';

class HymnRepositoryDev implements HymnRepository {
  final DataService _dataService;

  HymnRepositoryDev({required DataService dataService})
    : _dataService = dataService;

  @override
  Future<Result<List<Hymn>>> getHymns(String hymnalLanguage) async {
    final result = await _dataService.getHymns(hymnalLanguage);
    if (result is Success<List<Hymn>>) {
      return Result.success(result.data);
    }
    return Result.error((result as Error<List<Hymn>>).error);
  }
}
