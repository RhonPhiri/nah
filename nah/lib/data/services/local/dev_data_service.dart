import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nah/config/assets.dart';
import 'package:nah/data/domain/models/hymn/hymn.dart';
import 'package:nah/data/services/data_service.dart';

/// [DevDataService] contains mock up methods that will be provided by the DB once it is implementated
///
class DevDataService implements DataService {
  /// Method to load the embedded assets
  ///
  Future<List<Map<String, dynamic>>> _loadEmbeddedAsset(String asset) async {
    final localData = await rootBundle.loadString(asset);
    return (jsonDecode(localData) as List).cast<Map<String, dynamic>>();
  }

  /// Method to mimick loading of hymns from a data service depending on the language of the hymnal
  ///
  @override
  Future<List<Hymn>> getHymns(String hymnalLanguage) async {
    final hymns = await _loadEmbeddedAsset(
      "${Assets.hymns}$hymnalLanguage.json",
    );
    return hymns.map<Hymn>(Hymn.fromJson).toList();
  }
}
