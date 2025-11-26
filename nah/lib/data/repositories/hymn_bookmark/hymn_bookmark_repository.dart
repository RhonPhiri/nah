import 'package:nah/domain/models/hymn_bookmark/hymn_bookmark.dart';
import 'package:nah/utils/result.dart';

/// [HymnBookmarkRepository] class manages the functionality involved in managing hymn bookmarks
///
abstract class HymnBookmarkRepository {
  /// Method to create a bookmark
  Future<Result<void>> createHymnBookmark(HymnBookmark bookmark);

  /// Method to delete a hymnBookmark from the database
  Future<Result<bool>> deleteHymnBookmark(HymnBookmark bookmark);

  /// Method to get hymnBookmarks associated with a particular collection
  Future<Result<List<HymnBookmark>>> getHymnBookmarks(int hymnCollectionId);
}
