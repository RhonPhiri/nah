import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/utils/result.dart';

/// [HymnRepository] manages all the functions between hymns and data services
abstract class HymnRepository {
  /// Method to fetch hymns from data service
  Future<Result<List<Hymn>>> getHymns(String hymnalLanguage);
}
