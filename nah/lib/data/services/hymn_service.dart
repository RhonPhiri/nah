//Class to fetch hymn data

import 'package:flutter/material.dart';

import 'nah_services_export.dart';

class HymnService extends BaseService {
  //fetch hymn data using the fetch data method
  Future<Result<String>> fetchHymns(String language) async {
    final hymnFilePath = 'assets/hymns/$language.json';
    debugPrint("HYMN SERVICE: hymns fetched");
    return fetchEmbeddedData(hymnFilePath);
  }
}
