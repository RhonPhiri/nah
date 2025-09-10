import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nah/config/assets.dart';
import 'package:nah/data/service/data_service.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';

/// [DataServiceEmbedded] class managing the loading of data embedded in the app assets
class DataServiceEmbedded implements DataService {
  /// Method to load the embedded asset based on the provided path
  Future<List<Map<String, Object?>>> _loadStringAsset(String asset) async {
    final data = await rootBundle.loadString(asset);
    return (jsonDecode(data) as List).cast<Map<String, Object?>>();
  }

  /// Method to load hymnals from the assets folder
  @override
  Future<List<Hymnal>> getHymnals() async {
    final mapList = await _loadStringAsset(Assets.hymnals);
    return mapList.map(Hymnal.fromMap).toList();
  }

  /// Method to load hymns from the assets folder
  @override
  Future<List<Hymn>> getHymns(String language) async {
    final mapList = await _loadStringAsset(
      "${Assets.hymns}/${language.toLowerCase()}.json",
    );
    return mapList.map(Hymn.fromMap).toList();
  }
}
