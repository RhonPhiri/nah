import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';

/// [DataService] implements the basic methods and functions to provide data to the repos
abstract interface class DataService {
  /// Method to get hymns from the respective data service provider
  Future<List<Hymn>> getHymns(String hymnalLanguage);

  /// Method to get hymnals from the respective data service provider
  Future<List<Hymnal>> getHymnals();
}
