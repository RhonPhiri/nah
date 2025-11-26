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
    final result = await _dataService.insertHymnCollection(hymnCol);
    if (result is Success<void>) {
      return Result.success(null);
    }
    return Result.error((result as Error<void>).error);
  }

  @override
  Future<Result<void>> deleteHymnCollection(HymnCollection hymnCol) async {
    final result = await _dataService.deleteHymnCollection(hymnCol);
    if (result is Success<void>) {
      return Result.success(null);
    }
    return Result.error((result as Error<void>).error);
  }

  @override
  Future<Result<void>> editHymnCollection(HymnCollection hymnCol) async {
    final result = await _dataService.editHymnCollection(hymnCol);
    if (result is Success<void>) {
      return Result.success(null);
    }
    return Result.error((result as Error<void>).error);
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
