import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:nah/config/assets.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/data/services/db/nah_db_parameters.dart';
import 'package:nah/data/services/db/nah_db_utils.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_bookmark/hymn_bookmark.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NahDbService implements DataService {
  final log = Logger("NAH_DB_SERVICE");

  /// Variable to cache the database instance
  static Database? _database;

  /// Getter to retain an instance of the database
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  /// Method called during initial initialization of the database
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, nahDnName);

    // await _ensurePrebuiltDbCopied(path);

    return await openDatabase(
      path,
      version: 1,

      // Add support for cascade delete
      onConfigure: _onConfigure,

      // This won't run if the DB already exists
      onCreate: (db, version) => _onCreate(db, version, path),

      onOpen: _onOpen,
    );
  }

  // Method to run during database initialization; Copying the prebuilt database into the device
  // Future<void> _ensurePrebuiltDbCopied(String destPath) async {
  //   // Path on the device obtained using the getFatabasesPath() method + join & loading it itno FILE()
  //   final destFile = File(destPath);
  //   // Stop the function if the file laredy exists
  //   if (await destFile.exists()) {
  //     log.fine("NahDatabase already exists 👍");
  //     return;
  //   }

  //   log.fine("Loading prebuit Nah Database 🔥");
  //   // Since flutter is now running, rootbundle can now be used and loaded inform of bytes
  //   try {
  //     final data = await rootBundle.load(Assets.prebuiltDb);
  //     final bytes = data.buffer.asUint8List();
  //     // Recursive true; Creates the file and libraries if not created yet
  //     await destFile.create(recursive: true);
  //     await destFile.writeAsBytes(bytes, flush: true);
  //   } on Exception catch (e) {
  //     log.warning("Error loading the prebuilt NahDb", e);
  //   }
  // }

  /// Method to add support for cascade delete
  FutureOr<void> _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  /// Method to populate the database upon creation
  FutureOr<void> _onCreate(Database db, int version, String path) async {
    // if (await databaseExists(path)) return;
    db.execute('''
      CREATE TABLE hymnal (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        language TEXT NOT NULL
     );
    ''');

    db.execute('''
      CREATE TABLE hymn (
        id INTEGER NOT NULL,
        title TEXT NOT NULL,
        details TEXT,
        lyrics TEXT NOT NULL,
        hymnalId INTEGER NOT NULL,
        PRIMARY KEY(id, hymnalId),
        FOREIGN KEY (hymnalId) REFERENCES hymnal (id)
          ON UPDATE CASCADE
          ON DELETE CASCADE
        );
    ''');

    db.execute('''
      CREATE TABLE hymn_collection (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL UNIQUE,
        description TEXT
      );
    ''');

    db.execute('''
      CREATE TABLE hymn_bookmark (
	      id INTEGER NOT NULL,
	      title TEXT NOT NULL,
	      hymnCollectionId INTEGER NOT NULL,
	      hymnalId INTEGER NOT NULL,
        PRIMARY KEY (id, hymnCollectionId)
	      FOREIGN KEY (hymnCollectionId) REFERENCES hymn_collection (id)
	        ON UPDATE CASCADE
	        ON DELETE CASCADE,
        FOREIGN KEY (hymnalId) REFERENCES hymnal (id)
          ON UPDATE CASCADE
          ON DELETE CASCADE
      );
    ''');
    await _insertHymnalData(db);

    await db.execute(
      'CREATE INDEX idx_hymn_hymnal_id ON $tableHymn (hymnalId);',
    );
    await db.execute(
      'CREATE INDEX idx_bookmark_collection_id ON $tableHymnBookmark (hymnCollectionId);',
    );
  }

  List<Map<String, dynamic>> _parseJsonForCompute(String jsonData) {
    return (jsonDecode(jsonData) as List).cast<Map<String, dynamic>>();
  }

  Future<void> _insertHymnalData(Database db) async {
    final hymnalJson = await rootBundle.loadString(Assets.hymnals);

    final hymnalMaps = await compute(_parseJsonForCompute, hymnalJson);

    final hymnals = hymnalMaps.map(Hymnal.fromJson).toList();

    final batch = db.batch();

    for (Hymnal hymnal in hymnals) {
      batch.insert(tableHymnal, hymnal.toJson(), conflictAlgorithm: .replace);
    }

    await batch.commit(noResult: true);

    for (Hymnal hymnal in hymnals) {
      await _insertHymnData(
        database: db,
        hymnalId: hymnal.id,
        language: hymnal.language,
      );
    }
  }

  Future<void> _insertHymnData({
    required Database database,
    required int hymnalId,
    required String language,
  }) async {
    try {
      final hymnJson = await rootBundle.loadString(
        "${Assets.hymns}${language.toLowerCase()}.json",
      );

      final hymnMaps = await compute(_parseJsonForCompute, hymnJson);

      final hymns = hymnMaps.map(Hymn.fromJson).toList();

      final batch = database.batch();

      // Manual encoding
      //
      for (Hymn hymn in hymns) {
        batch.insert(
          tableHymn,
          hymnMapper(hymn, hymnalId),
          conflictAlgorithm: .replace,
        );
      }

      await batch.commit(noResult: true);
    } on Exception catch (e) {
      log.warning("Error inserting hymns into the dataabse", e);
    }
  }

  /// Method to print the version of the database
  FutureOr<void> _onOpen(Database db) async {
    log.info("db Version ${await db.getVersion()}");
  }

  @override
  Future<Result<List<Hymnal>>> getHymnals() async {
    final db = await database;

    try {
      final hymnalMaps = await db.query(tableHymnal);

      final hymnals = hymnalMaps.map(Hymnal.fromJson).toList();

      return Result.success(hymnals);
    } catch (e, stackTrace) {
      log.severe("Failed to get HYMNALS", e, stackTrace);
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Hymn>>> getHymns(int hymnalId, {int? hymnId}) async {
    final db = await database;

    final List<Map<String, Object?>> hymnMaps;
    try {
      if (hymnId != null) {
        hymnMaps = await db.query(
          tableHymn,
          where: "id = ? AND hymnalId = ?",
          whereArgs: [hymnId, hymnalId],
        );
      } else {
        hymnMaps = await db.query(
          tableHymn,
          where: "hymnalId = ?",
          whereArgs: [hymnalId],
        );
      }

      // Haven't used the fromJson method provided by freezed because I have to decode the details & lyrics
      // They were stored as Strings. Decoding will expose them as Maps
      final hymns = hymnMaps.map(hymnFromMap).toList();

      return Result.success(hymns);
    } catch (e, stackTrace) {
      log.severe("Failed to get HYMNS", e, stackTrace);
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<int>> insertHymnBookmark(HymnBookmark bookmark) async {
    final db = await database;
    try {
      final id = await db.insert(
        tableHymnBookmark,
        bookmark.toJson(),
        conflictAlgorithm: .replace,
      );

      if (id == 0) {
        log.severe("Error on Inserting the hymn bookmark into the database");
        return Result.error(
          Exception("Error on Inserting the hymn bookmark into the database"),
        );
      }
      return Result.success(id);
    } on Exception catch (e, stackTrace) {
      log.severe("Failed to insert hymn bookmarks", e, stackTrace);
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<HymnBookmark>>> getHymnBookmarks(
    int hymnCollectionId,
  ) async {
    final db = await database;
    try {
      final hymnBookmarkMaps = await db.query(
        tableHymnBookmark,
        where: 'hymnCollectionId = ?',
        whereArgs: [hymnCollectionId],
      );

      final hymnBookmarks = hymnBookmarkMaps
          .map(HymnBookmark.fromJson)
          .toList();

      return Result.success(hymnBookmarks);
    } catch (e, stackTrace) {
      log.severe("Failed to get hymn bookmarks", e, stackTrace);
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<int>> deleteHymnBookmark(HymnBookmark bookmark) async {
    final db = await database;

    try {
      final no = await db.delete(
        tableHymnBookmark,
        where: 'id = ? AND hymnCollectionId = ?',
        whereArgs: [bookmark.id, bookmark.hymnCollectionId],
      );

      if (no == 0) {
        final message = "Error deleting the hymn bookmark ${bookmark.title}";
        log.severe(message);
        return Result.error(Exception(message));
      } else {
        return Result.success(no);
      }
    } catch (e, stackTrace) {
      final message = "Failed to delete the hymn bookmark ${bookmark.title}";
      log.severe(message, e, stackTrace);
      return Result.error(Exception("$message; ${e.toString()}"));
    }
  }

  @override
  Future<Result<int>> insertHymnCollection(HymnCollection hymnCol) async {
    final db = await database;
    try {
      final id = await db.insert(
        tableHymnCollection,
        hymnCol.toJson(),
        conflictAlgorithm: .replace,
      );

      if (id == 0) {
        final message =
            "Error on Inserting the hymn collection into the database";
        log.severe(message);
        return Result.error(Exception(message));
      }
      return Result.success(id);
    } on Exception catch (e, stackTrace) {
      log.severe(
        "Failed to insert hymn collections into database",
        e,
        stackTrace,
      );
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<int>> deleteHymnCollection(HymnCollection hymnCol) async {
    final db = await database;

    try {
      final no = await db.delete(
        tableHymnCollection,
        where: 'id = ?',
        whereArgs: [hymnCol.id],
      );

      if (no == 0) {
        final message = "Error deleting the hymn collection ${hymnCol.title}";
        log.severe(message);
        return Result.error(Exception(message));
      } else {
        return Result.success(no);
      }
    } catch (e, stackTrace) {
      final message = "Failed to delete the hymn collection ${hymnCol.title}";
      log.severe(message, e, stackTrace);
      return Result.error(Exception("$message; ${e.toString()}"));
    }
  }

  @override
  Future<Result<int>> editHymnCollection(HymnCollection hymnCol) async {
    final db = await database;

    try {
      final no = await db.update(
        tableHymnCollection,
        hymnCol.toJson(),
        where: 'id = ?',
        whereArgs: [hymnCol.id],
        conflictAlgorithm: .abort,
      );

      if (no == 0) {
        final message = "Error updating ${hymnCol.title}";
        log.severe(message);
        return Result.error(Exception(message));
      }

      return Result.success(no);
    } catch (e, stackTrace) {
      final message = "Error updating ${hymnCol.title}";
      log.severe(message, e, stackTrace);
      return Result.error(Exception("$message; ${e.toString()}"));
    }
  }

  @override
  Future<Result<List<HymnCollection>>> getHymnCollections() async {
    final db = await database;
    try {
      final hymnCollectionMaps = await db.query(tableHymnCollection);

      final hymnCollections = hymnCollectionMaps
          .map(HymnCollection.fromJson)
          .toList();

      return Result.success(hymnCollections);
    } catch (e, stackTrace) {
      log.severe("Failed to get hymn collections", e, stackTrace);
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    try {
      await _database?.close();
    } on Exception catch (e, stackTrace) {
      log.severe("Error closing the database", e, stackTrace);
    }
  }
}
