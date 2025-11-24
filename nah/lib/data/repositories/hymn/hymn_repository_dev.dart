import 'package:nah/data/domain/models/hymn/hymn.dart';
import 'package:nah/data/repositories/hymn/hymn_repository.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';

class HymnRepositoryDev extends HymnRepository {
  final DataService _dataService;

  HymnRepositoryDev({required DataService dataService})
    : _dataService = dataService;

  static const name = "HYMN_REPOSITORY_DEV";

  @override
  Future<Result<List<Hymn>>> getHymns(String hymnalLanguage) async {
    try {
      final hymns = await _dataService.getHymns(hymnalLanguage);
      return Result.success(hymns);
    } on Exception catch (e, stackTrace) {
      return Result.error(Exception("$e, $stackTrace"));
    }
  }
}
