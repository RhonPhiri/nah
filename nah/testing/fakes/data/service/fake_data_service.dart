import 'package:flutter/foundation.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
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

  ///
  /// Method to get a sample hymn
  @override
  Future<Result<List<Hymn>>> getHymns(String hymnalLanguage) async {
    return SynchronousFuture(Result.success([kEnglishHymn]));
  }

  @override
  Future<Result<List<Hymnal>>> getHymnals() {
    return SynchronousFuture(Result.success([kHymnal]));
  }

  @override
  Future<Result<void>> deleteHymnCollection(HymnCollection hymnCol) async {
    hymnCollections.removeWhere((hc) => hc.id == hymnCol.id);
    return Result.success(null);
  }

  @override
  Future<Result<void>> editHymnCollection(HymnCollection hymnCol) async {
    final idx = hymnCollections.indexWhere((hc) => hc.id == hymnCol.id);
    hymnCollections[idx] = hymnCol;

    return Result.success(null);
  }

  @override
  Future<Result<void>> insertHymnCollection(HymnCollection hymnCol) async {
    hymnCollections.add(hymnCol);
    return Result.success(null);
  }

  @override
  void close() {
    hymnCollections.clear();
  }

  @override
  Future<Result<List<HymnCollection>>> getHymnCollections() async {
    return SynchronousFuture(Result.success(hymnCollections));
  }
}
