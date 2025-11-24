import 'package:flutter/foundation.dart';
import 'package:nah/data/domain/models/hymn/hymn.dart';
import 'package:nah/data/services/data_service.dart';
import '../../domain/models/hymn.dart';

/// [FakeDataService] implements the [DataService] and provides synchronous responses to the implemented methods
///
class FakeDataService implements DataService {
  ///
  /// Method to get a sample hymn
  @override
  Future<List<Hymn>> getHymns(String hymnalLanguage) async {
    return SynchronousFuture([kEnglishHymn]);
  }
}
