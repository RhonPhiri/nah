import 'package:nah/data/repositories/hymn_collection/hymn_collection_repository.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/utils/result.dart';

class HymnCollectionRepositoryDev implements HymnCollectionRepository {
  final DataService _dataService;

  HymnCollectionRepositoryDev({required DataService dataService})
    : _dataService = dataService;
  @override
  Future<Result<void>> createHymnCollection(HymnCollection hymnCol) async {
    try {
      await _dataService.insertHymnCollection(hymnCol);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> deleteHymnCollection(HymnCollection hymnCol) async {
    try {
      await _dataService.deleteHymnCollection(hymnCol);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> editHymnCollection(HymnCollection hymnCol) async {
    try {
      await _dataService.editHymnCollection(hymnCol);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<List<HymnCollection>>> getHymnCollections() async {
    final result = await _dataService.getHymnCollections();
    if (result is Success<List<HymnCollection>>) {
      return Result.success(result.data);
    }
    return Result.error((result as Error<List<HymnCollection>>).error);
  }
}
