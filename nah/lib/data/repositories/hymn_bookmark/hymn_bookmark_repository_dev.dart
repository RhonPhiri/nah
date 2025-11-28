import 'package:nah/data/repositories/hymn_bookmark/hymn_bookmark_repository.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/domain/models/hymn_bookmark/hymn_bookmark.dart';
import 'package:nah/utils/result.dart';

class HymnBookmarkRepositoryDev implements HymnBookmarkRepository {
  final DataService _dataService;

  HymnBookmarkRepositoryDev({required DataService dataService})
    : _dataService = dataService;

  @override
  Future<Result<void>> createHymnBookmark(HymnBookmark bookmark) async {
    final result = await _dataService.insertHymnBookmark(bookmark);
    if (result is Success<void>) {
      return Result.success(null);
    }
    return Result.error((result as Error<void>).error);
  }

  @override
  Future<Result<int>> deleteHymnBookmark(HymnBookmark bookmark) async {
    final result = await _dataService.deleteHymnBookmark(bookmark);
    if (result is Success<int>) {
      return Result.success(result.data);
    }
    return Result.error((result as Error<void>).error);
  }

  @override
  Future<Result<List<HymnBookmark>>> getHymnBookmarks(
    int hymnCollectionId,
  ) async {
    final result = await _dataService.getHymnBookmarks(hymnCollectionId);
    if (result is Success<List<HymnBookmark>>) {
      return Result.success(result.data);
    }
    return Result.error((result as Error<void>).error);
  }
}
