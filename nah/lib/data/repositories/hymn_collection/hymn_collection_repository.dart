import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/utils/result.dart';

/// [HymnCollectionRepository] class manages the functionality involved in managing hymn collections
///
abstract class HymnCollectionRepository {
  /// Method to create a hymn collection in the database
  Future<Result<void>> createHymnCollection(HymnCollection hymnCol);

  /// Method to remove a hymn collection from the database
  Future<Result<void>> deleteHymnCollection(HymnCollection hymnCol);

  /// Method to edit an existing hymn collection in the database
  Future<Result<void>> editHymnCollection(HymnCollection hymnCol);
}
