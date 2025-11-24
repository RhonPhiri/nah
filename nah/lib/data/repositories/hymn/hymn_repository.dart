import 'package:nah/data/domain/models/hymn/hymn.dart';
import 'package:nah/utils/result.dart';

/// Implementation of managing the hymn data obtained from the hymn service
abstract class HymnRepository {
  /// Method to get hymns from the hymn service based on the language of the hymnal they are incorporated in
  Future<Result<List<Hymn>>> getHymns(String hymnalLanguage);
}
