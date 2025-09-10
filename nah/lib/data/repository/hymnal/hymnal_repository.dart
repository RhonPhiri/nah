import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

/// [HymnalRepository] manages all the operations between hymnals and data services
abstract class HymnalRepository {
  ///Method to get the hymnal language stored using shared preferences
  Future<Result<String?>> getStoredHymnaLanguage();

  ///Method to set the hymnal language using shared preferences
  Future<Result<void>> setHymnalLanguage(String language);

  ///Method to get hymnals
  Future<Result<List<Hymnal>>> getHymnals();
}
