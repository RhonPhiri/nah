import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/utils/result.dart';

/// Abstract implementation for managing the hymn data obtained from the data service
abstract class HymnRepository {
  /// Method to get hymns based on the language of the hymnal they are associated with
  /// If the Id is provided, in a case of a fetching a specific hymn like that from a bookmark reference
  Future<Result<List<Hymn>>> getHymns(String hymnalLanguage, {int? hymnId});
}
