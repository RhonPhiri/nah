import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

/// [DataService] implements the basic methods and functions to provide data to the repos
abstract interface class DataService {
  /// Method to get hymns from the respective data service provider
  Future<Result<List<Hymn>>> getHymns(String hymnalLanguage);

  /// Method to get hymnals from the respective data service provider
  Future<Result<List<Hymnal>>> getHymnals();

  /// Method to insert hymn collections into the hymn collection table on creating it
  Future<Result<void>> insertHymnCollection(HymnCollection hymnCol);

  /// Method to remove a hymn collection from the hymn collection table
  Future<Result<void>> deleteHymnCollection(HymnCollection hymnCol);

  /// Method to edit an exoisting hymn collection in the database
  Future<Result<void>> editHymnCollection(HymnCollection hymnCol);

  /// Method to get hymnCollections from the data service provider
  Future<Result<List<HymnCollection>>> getHymnCollections();

  /// Method to dispose resources
  void close();
}
