import 'package:flutter/foundation.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/data/services/data_service.dart';
import '../../domain/models/hymn.dart';
import '../../domain/models/hymnal.dart';

/// [FakeDataService] implements the [DataService] and provides synchronous responses to the implemented methods
///
class FakeDataService implements DataService {
  final List<HymnCollection> hymnCollections = [];

  ///
  /// Method to get a sample hymn
  @override
  Future<List<Hymn>> getHymns(String hymnalLanguage) async {
    return SynchronousFuture([kEnglishHymn]);
  }

  @override
  Future<List<Hymnal>> getHymnals() {
    return SynchronousFuture([kHymnal]);
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
