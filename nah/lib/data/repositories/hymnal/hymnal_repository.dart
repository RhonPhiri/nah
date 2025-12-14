import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

/// Implementation for managing the hymnal data obtained from the data service
abstract class HymnalRepository {
  /// Method to get hymnals
  Future<Result<List<Hymnal>>> getHymnals();

  /// Method to store the selected hymnal
  Future<Result<void>> storeSelectedHymnal(String hymnal);

  /// Method to fetch the hymnal that was selected on last usage
  Future<Result<String?>> getStoredHymnal();
}
