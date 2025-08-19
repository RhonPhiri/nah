import 'package:flutter/material.dart';
import 'package:nah/data/db/nah_db.dart';
import 'package:nah/data/models/bookmark_model.dart';
import 'package:nah/data/services/nah_services_export.dart';

class BookmarkRepository {
  final NahDb _nahDb;

  BookmarkRepository(this._nahDb);

  ///method to cache bookmarks to database
  Future<void> cacheBm(Bookmark bookmark) async {
    await _nahDb.insertBm(bookmark);
    debugPrint("BM REPO: ${bookmark.title} cached successfully");
  }

  ///Method to get bookmarks from database
  Future<Result<List<Bookmark>>> fetchBm() async {
    try {
      final cachedBms = await _nahDb.getBm();
      if (cachedBms.isNotEmpty) {
        debugPrint("BM REPO: Bookmarks fetched successfully");

        return Success(cachedBms);
      }
      debugPrint("BM REPO: Bookmarks not successfully fetched");

      return Failure(
        Exception('BM REPO: Failed to retrive bookmarks from database'),
      );
    } catch (e) {
      return Failure(
        Exception(
          "BM REPO: Failed to retrieve bookmarks from database: ${e.toString()}",
        ),
      );
    }
  }

  ///method to delete bookmarks from database
  Future<void> deleteBm(Bookmark bm) async {
    await _nahDb.deleteBm(bm);
    debugPrint("BM REPO: Bookmarks deleted successfully");
  }
}
