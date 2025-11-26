import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

/// Implementation for managing the hymnal data obtained from the data service
abstract class HymnalRepository {
  /// Method to get hymnals
  Future<Result<List<Hymnal>>> getHymnals();
}
