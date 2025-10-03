import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';

/// [DataService] class to manage the extraction & setting of data in storage services
abstract class DataService {
  /// Method to store hymnals into the data service
  Future<void> setHymnals(List<Hymnal> hymnals);

  /// Method to load fetch hymnals data service
  Future<List<Hymnal>> getHymnals();

  /// Method to store all hymns into the data service
  Future<void> setHymns(String language);

  /// Method to load fetch hymns from data service using the hymnal Language
  Future<List<Hymn>> getHymns(String hymnalLanguage);
}
