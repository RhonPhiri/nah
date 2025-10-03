import 'dart:convert';

import 'package:nah/config/assets.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:flutter/services.dart';

/// [DevDataService] manages the embedded assets with the local variables in place of a database
class DevDataService implements DataService {
  // Variable holding the hymnals
  List<Hymnal> hymnals = [];

  // Variable to hold hymn data
  Map<String, List<Hymn>> hymnData = {};

  /// Method to load the embedded asset based on the provided path
  Future<List<Map<String, Object?>>> _loadStringAsset(String asset) async {
    final data = await rootBundle.loadString(asset);
    return (jsonDecode(data) as List).cast<Map<String, Object?>>();
  }

  @override
  Future<List<Hymnal>> getHymnals() async {
    return hymnals;
  }

  @override
  Future<List<Hymn>> getHymns(String hymnalLanguage) async {
    return hymnData[hymnalLanguage]!;
  }

  @override
  Future<void> setHymnals(List<Hymnal> hymnals) async {
    final hymnalMaps = await _loadStringAsset(Assets.hymnals);
    hymnals
      ..addAll(hymnalMaps.map<Hymnal>((hymnal) => Hymnal.fromMap(hymnal)))
      ..forEach((hymnal) async => setHymns(hymnal.language));
  }

  @override
  Future<void> setHymns(String language) async {
    final hymnMaps = await _loadStringAsset("${Assets.hymns}$language.json");
    hymnData[language] = hymnMaps
        .map<Hymn>((hymn) => Hymn.fromMap(hymn))
        .toList();
  }
}
