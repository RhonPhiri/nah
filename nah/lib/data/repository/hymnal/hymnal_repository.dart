import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

/// [HymnalRepository] manages all the operations between hymnals and data services
abstract class HymnalRepository {
  ///Method to get the hymnal stored using shared preferences
  Future<Result<Hymnal>> getStoredHymnal();

  ///Method to set the hymnal using shared preferences
  Future<Result<void>> setHymnal(Hymnal hymnal);

  ///Method to get hymnals
  Future<Result<List<Hymnal>>> getHymnals();
}
