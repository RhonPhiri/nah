import 'package:flutter/material.dart';
import 'package:nah/data/db/nah_db.dart';
import 'package:nah/data/models/hymn_collection_model.dart';
import 'package:nah/data/services/result.dart';

class HymnCollectionRepo {
  ///Using depency injection
  final NahDb _nahDb;

  HymnCollectionRepo(this._nahDb);

  ///Method to cache hymnCollections into the database
  Future<void> cacheHc(HymnCollection hymnCol) async {
    await _nahDb.insertHc(hymnCol);
    debugPrint("HC REPO: ${hymnCol.title} cached to database successfully");
  }

  ///Method to delete a hymn collection
  Future<void> deleteHc(HymnCollection hc) async {
    await _nahDb.deleteHc(hc);
    debugPrint("HC REPO: ${hc.title} removed from database successfully");
  }

  ///Method to retrieve hymnCols from the database
  Future<Result<List<HymnCollection>>> fetchHcs() async {
    try {
      final cachedHcs = await _nahDb.getHcs();

      if (cachedHcs.isNotEmpty) {
        return Success(cachedHcs);
      } else {
        return Failure(
          Exception("No cached hymn collections were found in the database"),
        );
      }
    } catch (e) {
      return Failure(
        Exception("Failed to load cached hymn collections from database"),
      );
    }
  }
}
