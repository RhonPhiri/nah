import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:nah/config/assets.dart';
import 'package:nah/data/services/data_service.dart';
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
    /// Create hymnal table
    await db.execute('''
      CREATE TABLE hymnal (
	      hymnal_id INTEGER PRIMARY KEY,
	      hymnal_title TEXT NOT NULL,
	      hymnal_language TEXT NOT NULL
      );
    ''');

    /// Create hymn table
    await db.execute('''
      CREATE TABLE hymn (
        hymn_id INTEGER,
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

    /// Create hymn_collection table
    await db.execute('''
      CREATE TABLE hymn_collection (
	      hymn_collection_id INTEGER PRIMARY KEY,
	      hymn_collection_title TEXT NOT NULL UNIQUE,
      	hymn_collection_description TEXT
      );
    ''');

    /// Create hymn_bookmark table
    await db.execute('''
      CREATE TABLE hymn_bookmark (
	      hymn_bookmark_id INTEGER PRIMARY KEY,
	      hymn_bookmark_title TEXT NOT NULL,
	      hymn_collection_id INTEGER NOT NULL,
	      hymnal_id INTEGER NOT NULL,
	      FOREIGN KEY (hymn_collection_id) REFERENCES hymn_collection (hymn_collection_id)
	        ON UPDATE CASCADE
	        ON DELETE CASCADE,
	      FOREIGN KEY (hymnal_id) REFERENCES hymnal (hymnal_id)
         ON UPDATE CASCADE
         ON DELETE CASCADE
      );
    ''');

    await _insertData(db);

    await db.execute('CREATE INDEX idx_hymn_hymnal_id ON hymn (hymnal_id);');
    await db.execute(
      'CREATE INDEX idx_bookmark_collection_id ON hymn_bookmark (hymn_collection_id);',
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
        'INSERT INTO hymnal (hymnal_id, hymnal_title, hymnal_language) VALUES (?, ?, ?)',
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
        'INSERT INTO hymn (hymn_id, hymn_title, hymn_details, hymn_lyrics, hymnal_id) VALUES (?, ?, ?, ?, ?)',
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
  FutureOr<void> _onOpen(Database db) async =>
      log.info("db Version ${await db.getVersion()}");

  @override
  Future<void> close() async {
    await _database?.close();
  }

  @override
  Future<Result<List<Hymnal>>> getHymnals() {
    // TODO: implement getHymnals
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Hymn>>> getHymns(int hymnalId, {int? hymnId}) {
    // TODO: implement getHymns
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> insertHymnBookmark(HymnBookmark bookmark) {
    // TODO: implement insertHymnBookmark
    throw UnimplementedError();
  }

  @override
  Future<Result<List<HymnBookmark>>> getHymnBookmarks(int hymnCollectionId) {
    // TODO: implement getHymnBookmarks
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> deleteHymnBookmark(HymnBookmark bookmark) {
    // TODO: implement deleteHymnBookmark
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> insertHymnCollection(HymnCollection hymnCol) {
    // TODO: implement insertHymnCollection
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> deleteHymnCollection(HymnCollection hymnCol) {
    // TODO: implement deleteHymnCollection
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> editHymnCollection(HymnCollection hymnCol) {
    // TODO: implement editHymnCollection
    throw UnimplementedError();
  }

  @override
  Future<Result<List<HymnCollection>>> getHymnCollections() {
    // TODO: implement getHymnCollections
    throw UnimplementedError();
  }
}
