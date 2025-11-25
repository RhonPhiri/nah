import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nah/config/assets.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/data/services/data_service.dart';

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
  Future<List<Hymn>> getHymns(String hymnalLanguage) async {
    final hymns = await _loadEmbeddedAsset(
      "${Assets.hymns}$hymnalLanguage.json",
    );
    return hymns.map<Hymn>(Hymn.fromJson).toList();
  }

  @override
  Future<List<Hymnal>> getHymnals() async {
    final hymnals = await _loadEmbeddedAsset(Assets.hymnals);
    return hymnals.map<Hymnal>(Hymnal.fromJson).toList();
  }

  @override
  Future<void> deleteHymnCollection(HymnCollection hymnCol) async {
    hymnCollections.removeWhere((hc) => hc.id == hymnCol.id);
  }

  @override
  Future<void> editHymnCollection(HymnCollection hymnCol) async {
    final idx = hymnCollections.indexWhere((hc) => hc.id == hymnCol.id);
    hymnCollections[idx] = hymnCol;
  }

  @override
  Future<void> insertHymnCollection(HymnCollection hymnCol) async {
    hymnCollections.add(hymnCol);
  }

  @override
  void close() {
    hymnCollections.clear();
  }
}
