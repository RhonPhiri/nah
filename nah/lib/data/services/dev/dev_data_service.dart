import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nah/config/assets.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';

/// [DevDataService] contains mock up methods
///
class DevDataService implements DataService {
  List<HymnCollection> hymnCollections = [];

  /// Method to load the embedded assets
  ///
  Future<List<Map<String, dynamic>>> _loadEmbeddedAsset(String asset) async {
    final localData = await rootBundle.loadString(asset);
    return (jsonDecode(localData) as List).cast<Map<String, dynamic>>();
  }

  @override
  Future<Result<List<Hymn>>> getHymns(String hymnalLanguage) async {
    final hymns = await _loadEmbeddedAsset(
      "${Assets.hymns}$hymnalLanguage.json",
    );
    return Result.success(hymns.map<Hymn>(Hymn.fromJson).toList());
  }

  @override
  Future<Result<List<Hymnal>>> getHymnals() async {
    final hymnals = await _loadEmbeddedAsset(Assets.hymnals);
    return Result.success(hymnals.map<Hymnal>(Hymnal.fromJson).toList());
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
    return Result.success(hymnCollections);
  }
}
