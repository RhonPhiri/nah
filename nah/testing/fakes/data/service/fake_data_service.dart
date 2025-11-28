import 'package:flutter/foundation.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_bookmark/hymn_bookmark.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';
import '../../domain/models/hymn.dart';
import '../../domain/models/hymnal.dart';

/// [FakeDataService] implements the [DataService] and provides synchronous responses to the implemented methods
///
class FakeDataService implements DataService {
  final List<HymnCollection> hymnCollections = [];

  final List<HymnBookmark> hymnBookmarks = [];

  ///
  /// Method to get a sample hymn
  @override
  Future<Result<List<Hymn>>> getHymns(int hymnalId, {int? hymnId}) async {
    if (hymnId != null) {
      return SynchronousFuture(
        Result.success([
          [kEnglishHymn].firstWhere((hymn) => hymn.id == hymnId),
        ]),
      );
    }
    return SynchronousFuture(Result.success([kEnglishHymn]));
  }

  @override
  Future<Result<List<Hymnal>>> getHymnals() {
    return SynchronousFuture(Result.success([kHymnal]));
  }

  @override
  Future<Result<int>> deleteHymnCollection(HymnCollection hymnCol) async {
    hymnCollections.remove(hymnCol);
    return SynchronousFuture(Result.success(1));
  }

  @override
  Future<Result<int>> editHymnCollection(HymnCollection hymnCol) async {
    final idx = hymnCollections.indexWhere((hc) => hc.id == hymnCol.id);
    hymnCollections[idx] = hymnCol;

    return Result.success(1);
  }

  @override
  Future<Result<int>> insertHymnCollection(HymnCollection hymnCol) async {
    hymnCollections.add(hymnCol);
    return Result.success(1);
  }

  @override
  Future<Result<List<HymnCollection>>> getHymnCollections() async {
    return SynchronousFuture(Result.success(hymnCollections));
  }

  @override
  Future<Result<int>> deleteHymnBookmark(HymnBookmark bookmark) async {
    hymnBookmarks.remove(bookmark);
    return SynchronousFuture(Result.success(1));
  }

  @override
  Future<Result<List<HymnBookmark>>> getHymnBookmarks(
    int hymnCollectionId,
  ) async {
    return SynchronousFuture(Result.success(hymnBookmarks));
  }

  @override
  Future<Result<int>> insertHymnBookmark(HymnBookmark bookmark) async {
    hymnBookmarks.add(bookmark);
    return SynchronousFuture(Result.success(1));
  }

  @override
  Future<void> close() async {
    hymnCollections.clear();
  }
}
