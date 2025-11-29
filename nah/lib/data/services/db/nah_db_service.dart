import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:nah/config/assets.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/data/services/db/nah_db_helper.dart';
import 'package:nah/data/services/db/nah_db_parameters.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_bookmark/hymn_bookmark.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NahDbService implements DataService {
  final log = Logger("NAH_DB_SERVICE");

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, nahDnName);

    await _ensurePrebuiltDbCopied(path);

    return await openDatabase(
      path,
      version: 1,

      // Add support for cascade delete
      onConfigure: _onConfigure,

      // This won't run if the DB already exists
      onCreate: _onCreate,

      onOpen: _onOpen,
    );
  }

  // Method to run during database initialization; Copying the prebuilt database into the device
  Future<void> _ensurePrebuiltDbCopied(String destPath) async {
    // Path on the device obtained using the getFatabasesPath() method + join & loading it itno FILE()
    final destFile = File(destPath);
    // Stop the function if the file laredy exists
    if (await destFile.exists()) return;
    // Since flutter is now running, rootbundle can now be used and loaded inform of bytes
    final data = await rootBundle.load('assets/nah_prebuilt.db');
    final bytes = data.buffer.asUint8List();
    // Recursive true; Creates the file and libraries if not created yet
    await destFile.create(recursive: true);
    await destFile.writeAsBytes(bytes, flush: true);
  }

  /// Method to add support for cascade delete
  FutureOr<void> _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  /// Method to populate the database upon creation
  FutureOr<void> _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE hymnal (
        hymnal_id INTEGER PRIMARY KEY,
        hymnal_title TEXT NOT NULL,
        hymnal_language TEXT NOT NULL
     );
    ''');

    db.execute('''
      CREATE TABLE hymn (
        hymn_id INTEGER NOT NULL,
        hymn_title TEXT NOT NULL,
        hymn_details TEXT,
        hymn_lyrics TEXT NOT NULL,
        hymnal_id INTEGER NOT NULL,
        PRIMARY KEY(hymn_id, hymnal_id),
        FOREIGN KEY (hymnal_id) REFERENCES hymnal (hymnal_id)
          ON UPDATE CASCADE
          ON DELETE CASCADE
        );
    ''');

    db.execute('''
      CREATE TABLE hymn_collection (
        hymn_collection_id INTEGER PRIMARY KEY,
        hymn_collection_title TEXT NOT NULL UNIQUE,
        hymn_collection_description TEXT
      );
    ''');

    db.execute('''
      CREATE TABLE hymn_bookmark (
	      hymn_bookmark_id INTEGER NOT NULL,
	      hymn_bookmark_title TEXT NOT NULL,
	      hymn_collection_id INTEGER NOT NULL,
	      hymnal_id INTEGER NOT NULL,
        PRIMARY KEY (hymn_bookmark_id, hymn_collection_id)
	      FOREIGN KEY (hymn_collection_id) REFERENCES hymn_collection (hymn_collection_id)
	        ON UPDATE CASCADE
	        ON DELETE CASCADE,
        FOREIGN KEY (hymnal_id) REFERENCES hymnal (hymnal_id)
          ON UPDATE CASCADE
          ON DELETE CASCADE
      );
    ''');
    await _insertData(db);

    await db.execute(
      'CREATE INDEX idx_hymn_hymnal_id ON $tableHymn (hymnal_id);',
    );
    await db.execute(
      'CREATE INDEX idx_bookmark_collection_id ON $tableHymnBookmark (hymn_collection_id);',
    );
  }

  Future<List<Map<String, dynamic>>> _loadEmbeddedAsset(String asset) async {
    final localData = await rootBundle.loadString(asset);
    return (jsonDecode(localData) as List).cast<Map<String, dynamic>>();
  }

  Future<void> _insertData(Database db) async {
    final hymnalMaps = await _loadEmbeddedAsset(Assets.hymnals);

    final hymnals = hymnalMaps.map(Hymnal.fromJson).toList();

    final batch = db.batch();

    for (Hymnal hymnal in hymnals) {
      batch.rawInsert(
        'INSERT INTO $tableHymnal (hymnal_id, hymnal_title, hymnal_language) VALUES (?, ?, ?)',
        [hymnal.id, hymnal.title, hymnal.language],
      );
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
    final hymnMaps = await _loadEmbeddedAsset("${Assets.hymns}$language.json");

    final hymns = hymnMaps.map(Hymn.fromJson).toList();

    final batch = database.batch();

    for (Hymn hymn in hymns) {
      batch.rawInsert(
        'INSERT INTO $tableHymn (hymn_id, hymn_title, hymn_details, hymn_lyrics, hymnal_id) VALUES (?, ?, ?, ?, ?)',
        [
          hymn.id,
          hymn.title,
          jsonEncode(hymn.details),
          jsonEncode(hymn.lyrics),
          hymnalId,
        ],
      );
    }

    await batch.commit(noResult: true);
  }

  /// Method to print the version of the database
  FutureOr<void> _onOpen(Database db) async {
    log.info("db Version ${await db.getVersion()}");
  }

  @override
  Future<Result<List<Hymnal>>> getHymnals() async {
    final db = await database;

    try {
      final hymnalMaps = await db.rawQuery('SELECT * FROM $tableHymnal');

      final hymnals = mapper<Hymnal>(hymnalMaps);

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
        hymnMaps = await db.rawQuery(
          'SELECT * FROM $tableHymn WHERE hymn_id = ? AND hymnal_id = ?',
          [hymnId, hymnalId],
        );
      } else {
        hymnMaps = await db.rawQuery(
          'SELECT * FROM $tableHymn WHERE hymnal_id = ?',
          [hymnalId],
        );
      }

      final hymns = mapper<Hymn>(hymnMaps);

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
      final id = await db.insert(tableHymnBookmark, {
        "hymn_bookmark_id": bookmark.id,
        "hymn_bookmark_title": bookmark.title,
        "hymn_collection_id": bookmark.hymnCollectionId,
        "hymnal_id": bookmark.hymnalId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

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
        where: 'hymn_collection_id = ?',
        whereArgs: [hymnCollectionId],
      );

      final hymnBookmarks = mapper<HymnBookmark>(hymnBookmarkMaps);

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
        where: 'hymn_bookmark_id = ? AND hymn_collection_id = ?',
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
      final id = await db.insert(tableHymnCollection, {
        "hymn_collection_id": hymnCol.id,
        "hymn_collection_title": hymnCol.title,
        "hymn_collection_description": hymnCol.description,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

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
        where: 'hymn_collection_id = ?',
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
        {
          "hymn_collection_id": hymnCol.id,
          "hymn_collection_title": hymnCol.title,
          "hymn_collection_description": hymnCol.description,
        },
        where: 'hymn_collection_id = ?',
        whereArgs: [hymnCol.id],
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

      final hymnCollections = mapper<HymnCollection>(hymnCollectionMaps);

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
