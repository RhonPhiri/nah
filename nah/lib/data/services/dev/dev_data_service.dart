import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nah/config/assets.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_bookmark/hymn_bookmark.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';

/// [DevDataService] contains mock up methods
///
class DevDataService implements DataService {
  List<HymnCollection> hymnCollections = [];

  List<HymnBookmark> hymnBookmarks = [];

  /// Method to load the embedded assets
  ///
  Future<List<Map<String, dynamic>>> _loadEmbeddedAsset(String asset) async {
    final localData = await rootBundle.loadString(asset);
    return (jsonDecode(localData) as List).cast<Map<String, dynamic>>();
  }

  @override
  Future<Result<List<Hymn>>> getHymns(
    String hymnalLanguage, {
    int? hymnId,
  }) async {
    final hymnMaps = await _loadEmbeddedAsset(
      "${Assets.hymns}$hymnalLanguage.json",
    );
    final hymns = hymnMaps.map<Hymn>(Hymn.fromJson).toList();

    if (hymnId == null) {
      return Result.success([hymns.firstWhere((hymn) => hymn.id == hymnId)]);
    }
    return Result.success(hymns);
  }

  @override
  Future<Result<List<Hymnal>>> getHymnals() async {
    final hymnals = await _loadEmbeddedAsset(Assets.hymnals);
    return Result.success(hymnals.map<Hymnal>(Hymnal.fromJson).toList());
  }

  @override
  Future<Result<bool>> deleteHymnCollection(HymnCollection hymnCol) async {
    final removed = hymnCollections.remove(hymnCol);
    return Result.success(removed);
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
  Future<Result<List<HymnCollection>>> getHymnCollections() async {
    return Result.success(hymnCollections);
  }

  @override
  Future<Result<List<HymnBookmark>>> getHymnBookmarks(
    int hymnCollectionId,
  ) async {
    return Result.success(
      hymnBookmarks
          .where((hymnBm) => hymnBm.hymnCollectionId == hymnCollectionId)
          .toList(),
    );
  }

  @override
  Future<Result<void>> insertHymnBookmark(HymnBookmark bookmark) async {
    hymnBookmarks.add(bookmark);
    return Result.success(null);
  }

  @override
  Future<Result<bool>> deleteHymnBookmark(HymnBookmark bookmark) async {
    final removed = hymnBookmarks.remove(bookmark);
    return Result.success(removed);
  }

  @override
  void close() {
    hymnCollections.clear();
  }
}
